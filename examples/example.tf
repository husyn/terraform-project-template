### VARIABLES ###
variable "project" { type = string }
variable "environment" { type = string }
variable "region" { type = string }

### MODULES ###

// call this module for every tf project deployment to setup the naming conventions
module "naming" {
  source        = "../modules/naming"
  project       = var.project
  environment   = var.environment
  resource_type = "testing"
  suffix        = "001"
}

### OUTPUTS ###

output "example_short_name" {
  value = module.naming.short_name
}

output "example_full_name" {
  value = module.naming.full_name
}

output "example_tag_friendly_name" {
  value = module.naming.tag_friendly_name
}

output "example_dns_name" {
  value = module.naming.dns_name
}