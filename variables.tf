variable "digitalocean_token" {
  type        = string
  description = "Digitalocean auth token"
}

variable "domain_name" {
  type        = string
  description = "Name of the domain"
  default     = "example.com"
}


variable "project_name" {
  type        = string
  description = "Name of the project to find"
  default     = "My_Project"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC we are using"
  default     = "my-vpc"
}

variable "droplet_size" {
  type        = string
  description = "Size of the droplet for Vault instances"
  default     = "s-1vcpu-1gb"
}

variable "ssh_public_key_url" {
  type        = string
  description = "URL of of the public ssh key to add to the droplet"
  default     = "https://github.com/brucellino.keys"
}

variable "instances" {
  type        = number
  description = "number of instances in the vault cluster"
  default     = 3
}

variable "username" {
  type        = string
  description = "Name of the non-root user to add"
  default     = "hashiuser"
}

variable "ssh_inbound_source_cidrs" {
  type        = list(any)
  description = "List of CIDRs from which we will allow ssh connections on port 22"
  default     = []
}
