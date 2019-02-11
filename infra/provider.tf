provider "aws" {
  version = "~> 1.58"
  region  = "us-west-2"
}

terraform {
  backend "s3" {}
}
