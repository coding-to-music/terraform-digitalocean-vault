output "droplet_size" {
  value = var.droplet_size
}

output "droplet_image" {
  value = var.droplet_image
}

output "domain_name" {
  value = format("%s%s","http://",var.domain_name)
}

output "droplet_ip_addresses" {
  value = digitalocean_droplet.vault[*].ipv4_address
}
