############### VARIABLES ##################
variable "project" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "resource_type" {
  type        = string
  description = "Type of resource (e.g., vpc, s3, ec2)"
}

variable "suffix" {
  type        = string
  description = "Optional suffix (e.g., 001, eu-west-1)"
  default     = ""
}

############### MODULE ##################
locals {
  # Core parts
  base_name         = "${var.project}-${var.environment}-${var.resource_type}"
  full_name         = var.suffix != "" ? "${local.base_name}-${var.suffix}" : local.base_name

  # Additional formats
  dns_name          = lower(replace(local.full_name, "_", "-"))
  tag_friendly_name = title(replace(local.full_name, "-", " "))
  short_name        = join("", [
    substr(var.project, 0, 3),
    substr(var.environment, 0, 3),
    substr(var.resource_type, 0, 3),
    var.suffix != "" ? substr(var.suffix, 0, 3) : ""
  ])
}

############### OUTPUT ##################
output "full_name" {
  value = local.full_name
}

output "dns_name" {
  value = local.dns_name
  description = "Lowercase with hyphens, safe for URLs or bucket names"
}

output "tag_friendly_name" {
  value = local.tag_friendly_name
  description = "Capitalized and space-separated, good for display in UIs or tags"
}

output "short_name" {
  value = lower(local.short_name)
  description = "Short ID useful in places like CloudWatch alarms or internal resource IDs"
}
