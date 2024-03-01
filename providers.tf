provider "aws" {
  region = var.region
  source  = "hashicorp/aws"
  version = "3.27"

}

provider "archive" {
  source  = "hashicorp/archive"
  version = "1.3.0"
}
