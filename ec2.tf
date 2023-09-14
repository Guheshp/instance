provider "aws" {
    region = "ap-south-1"
  profile = "gp"
}

resource "aws_key_pair" "keypair_ec2" {
  key_name   = "keypair-pub"
  public_key = file("${path.module}/id_rsa.pub")

}
  

resource "aws_instance" "grow" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = "keypair-pub"
    tags = {
        name = "terraform-instance"
    }
  

}
resource "aws_s3_bucket" "example" {
  bucket = var.aws_s3_bucket_name

  
}