
terraform {
  required_version = ">= 0.12"
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.7.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.51.1"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = "2.3.4"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}