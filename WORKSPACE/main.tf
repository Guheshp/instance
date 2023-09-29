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

data "aws_ami" "ubuntu" {

  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = [var.image]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "flipkart" {
    count = 4
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    vpc_security_group_ids =["${aws_security_group.allow_tls.id}"]

    tags ={
        Name = "device"
        name = "application"
        env = var.env
    }   

}

data "aws_instance" "flipkart"{
    instance_id = "i-09a92981e4fc7b68e"
}

resource "aws_instance" "duplicate" {
    ami = data.aws_instance.flipkart.ami
    instance_type = data.aws_instance.flipkart.instance_type
    vpc_security_group_ids = data.aws_instance.flipkart.vpc_security_group_ids
    tags = {
      Name = "device"
     
    }
  
} 



resource "aws_security_group" "allow_tls" {
  name        = "ag-group"
  description = "Allow TLS inbound traffic"


  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls"
  }
}

variable "region" {
    type = string
    description = "region name"
    default = "ap-south-1"
}

variable "image" {
    type = string
    description = "data source image name "
    default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "instance_type" {
    type = string
    description = "instance type"
    default = "t2.micro"  
}

variable "env" {
    type = string
    description = "workspace environment"

    
}

output "instance_id0" {
    value = aws_instance.flipkart[0].id
}
output "instance_id1" {
    value = aws_instance.flipkart[1].id
}

