data "digitalocean_vpc" "vpc" {
  name = var.vpc_name
}

data "digitalocean_project" "p" {
  name = var.project_name
}

data "digitalocean_images" "ubuntu" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  filter {
    key    = "regions"
    values = [data.digitalocean_vpc.vpc.region]
  }
  sort {
    key       = "created"
    direction = "desc"
  }
}

data "http" "ssh_key" {
  url = var.ssh_public_key_url
}

resource "digitalocean_domain" "cluster" {
  name = var.domain_name
}

resource "digitalocean_record" "lb" {
  domain = digitalocean_domain.cluster.name
  type   = "A"
  name   = "vault"
  value  = digitalocean_loadbalancer.external.ip
}

# resource "digitalocean_record" "droplets" {
#   for_each = toset(digitalocean_droplet.vault[*].ipv4_address)
#   domain   = digitalocean_domain.cluster.name
#   type     = "A"
#   name     = ""
#   value    = tostring(each.value)
# }

# resource "digitalocean_certificate" "cert" {
#   name    = "vault-external"
#   type    = "lets_encrypt"
#   domains = ["%s%s", "*.", var.domain_name]
#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "digitalocean_ssh_key" "vault" {
  name       = "Vault ssh key"
  public_key = data.http.ssh_key.response_body
  lifecycle {
    precondition {
      condition     = contains([201, 200, 204], data.http.ssh_key.status_code)
      error_message = "Status code is not OK"
    }
  }
}

resource "digitalocean_loadbalancer" "external" {
  name     = "vault-external"
  region   = data.digitalocean_vpc.vpc.region
  vpc_uuid = data.digitalocean_vpc.vpc.id
  forwarding_rule {
    entry_port  = 80
    target_port = 8200
    #tfsec:ignore:digitalocean-compute-enforce-https
    entry_protocol  = "http"
    target_protocol = "http"
  }


  # forwarding_rule {
  #   entry_port       = 443
  #   target_port      = 8200
  #   entry_protocol   = "https"
  #   target_protocol  = "http"
  #   certificate_name = digitalocean_certificate.cert.name
  # }

  healthcheck {
    # https://www.vaultproject.io/api-docs/system/health
    protocol               = "http"
    port                   = 8200
    path                   = "/v1/sys/health"
    check_interval_seconds = 10
    healthy_threshold      = 3
  }
  droplet_ids = digitalocean_droplet.vault[*].id
  # redirect_http_to_https = true
}

resource "digitalocean_droplet" "vault" {
  count         = var.instances
  image         = var.droplet_image
  # image         = data.digitalocean_images.ubuntu.images[0].slug which is "questdb-20-04"
  name          = "vault-${count.index}"
  region        = data.digitalocean_vpc.vpc.region
  size          = var.droplet_size
  vpc_uuid      = data.digitalocean_vpc.vpc.id
  ipv6          = false
  backups       = false
  monitoring    = true
  tags          = ["vault", "auto-destroy", var.droplet_image]
  # ssh_keys      = [digitalocean_ssh_key.vault.id]
  droplet_agent = true
  user_data = templatefile(
    "${path.module}/templates/userdata.tftpl",
    {
      vault_version = "1.11.0",
      username      = var.username,
      ssh_pub_key   = data.http.ssh_key.response_body
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "digitalocean_firewall" "ssh" {
  name        = "ssh"
  droplet_ids = digitalocean_droplet.vault[*].id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.ssh_inbound_source_cidrs
  }

  outbound_rule {
    protocol   = "tcp"
    port_range = "1-65535"
    #tfsec:ignore:digitalocean-compute-no-public-egress
    destination_addresses = ["0.0.0.0/0"]
  }
}

# resource "digitalocean_firewall" "lb" {
#   name = "web"

#   inbound_rule {
#     protocol         = "tcp"
#     port_range       = "443"
#     source_addresses = ["0.0.0.0/0"]
#   }

#   outbound_rule {
#     protocol              = "tcp"
#     port_range            = "1-65535"
#     destination_addresses = ["0.0.0.0/0"]
#   }
# }

resource "digitalocean_firewall" "vault" {
  name        = "vault"
  droplet_ids = digitalocean_droplet.vault[*].id

  inbound_rule {
    protocol                  = "tcp"
    port_range                = "8200-8201"
    source_load_balancer_uids = [digitalocean_loadbalancer.external.id]
  }
}

resource "digitalocean_project_resources" "vault_droplets" {
  project   = data.digitalocean_project.p.id
  resources = digitalocean_droplet.vault[*].urn
}

resource "digitalocean_project_resources" "network" {

  project = data.digitalocean_project.p.id

  resources = [
    digitalocean_loadbalancer.external.urn,
    digitalocean_domain.cluster.urn
  ]
}
