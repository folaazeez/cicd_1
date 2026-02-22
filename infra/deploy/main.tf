provider "aws" {
  region = "eu-west-2"
}

data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket         = "cicd1-bucket-fola"
    key            = "platform-foundations/foundation.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "cicd1-tbl"
    encrypt        = true
  }
}