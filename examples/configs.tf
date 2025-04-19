# Example Terraform configuration file for setting up a backend and naming conventions

terraform {
  backend "s3" {
    bucket         = "" # set via script
    key            = "" # set via script
    region         = ""
    encrypt        = true                           # enable server-side encryption
    use_lockfile   = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}