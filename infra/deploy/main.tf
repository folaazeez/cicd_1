provider "aws" {
  region = "eu-west-2"
}

data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket         = "pipelineguard-chatgpt-fola"
    key            = "platform-foundations/foundation.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "pipelineguard-chatgpt"
    encrypt        = true
  }
}