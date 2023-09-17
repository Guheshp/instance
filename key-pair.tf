#keypair -------------------------
resource "aws_key_pair" "keypair_ec2" {
  key_name   = "keypair-pub"
  public_key = file("${path.module}/id_rsa.pub")

}
