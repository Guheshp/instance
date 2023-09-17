variable "ami" {
  type    = string
}

variable "instance_type" {
  type    = string
}

variable "aws_s3_bucket_name" {
  type = string
}

variable "keypairs" {
  type = string
}

variable "ports" {
  type = list(number)
}