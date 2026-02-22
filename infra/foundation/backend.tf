terraform {
  backend "s3" {
    bucket         = "cicd1-bucket-fola"
    key            = "platform-foundations/foundation.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "cicd1-tbl"
    encrypt        = true
  }
}
