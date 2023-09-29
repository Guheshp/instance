terraform {
  required_providers {
    aws = {
        version = "~> 5"
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
  profile = "gp"
}

resource "aws_instance" "sample" {
  ami = "ami-0fe0238291c8e3f07"
  instance_type = var.instance_type
  for_each = toset(var.env) #Convert the list to a set to ensure uniqueness
}

variable "region" {
  type = string
  description = "AWS region"
  default = "ap-south-1"
}

variable "instance_type" {
  type = string
  description = "Instance type"
  default = "t2.micro"
}

variable "env" {
  type = list(string)
  description = "Env"
  default = [ "dev","prod","test" ]
}





