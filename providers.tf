provider "aws" {
  use_fips_endpoint = true
  region = var.region
}