variable "digitalocean_token" {
  type        = string
  description = "Digitalocean auth token"
}

variable "domain_name" {
  type        = string
  description = "Name of the domain"
  default     = "example.com"
}

variable "droplet_image" {
  type        = string
  description = "image to use for the droplet"
  default     = "ubuntu-20-04-x64"
}

variable "project_name" {
  type        = string
  description = "Name of the project to find"
  default     = "Datacenter"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC we are using"
  default     = "Datacenter"
}

variable "droplet_size" {
  type        = string
  description = "Size of the droplet for Vault instances"
  # default     = "s-1vcpu-1gb"
  default     = "s-1vcpu-512mb-10gb"
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
