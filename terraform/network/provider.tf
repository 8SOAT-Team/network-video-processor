terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ACG-Terraform-Labs-Teste"

    workspaces {
      name = "lab-migrate-state"
    }
  }
}

provider "aws" {
  access_key = "AKIAYQNJS2XQQRUQGXMZ"  ##var.aws_access_key
  secret_key = "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"  ##var.aws_secret_key
  region     = "us-east-1"  ##var.aws_region
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "us-east-1"
}