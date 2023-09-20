provider "aws" {
    region = "ap-south-1"
    
}

data "aws_ami" "ubuntu" {
     most_recent      = true
      owners           = ["099720109477"]

    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" ]
    }
    filter {
      name = "root-device-type"
      values = ["ebs"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
  
}
output "aws_ami" {
    value = data.aws_ami.ubuntu.id
}

resource "aws_instance" "name" {
 ami = data.aws_ami.ubuntu.id
 instance_type = "t2.micro"

}