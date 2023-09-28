
#security group------------
resource "aws_security_group" "allow_sg" {
  name        = "terraform-sg"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.ports      # ports [22,80,443 ,3306]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }
}