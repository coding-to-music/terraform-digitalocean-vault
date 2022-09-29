# This is the default example
# customise it as you see fit for your example usage of your module

# add provider configurations here, for example:
# provider "aws" {
#
# }

# Declare your backends and other terraform configuration here
# This is an example for using the consul backend.
# terraform {
#   backend "consul" {
#     path = "test_module/simple"
#   }
# }


# module "example" {
#   source = "../../"
#   dummy  = "test"
# }

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    # http = {
    #   source = "hashicorp/http"
    #   version = "3.0.1"
    # }
    # cloudflare = {
    #   source = "cloudflare/cloudflare"
    #   version = "~> 3.0"
    # }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}
