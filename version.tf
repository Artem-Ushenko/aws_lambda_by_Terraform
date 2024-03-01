terraform {
  required_version = ">= 1.6.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.27"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "1.3.0"
    }
  }

}
