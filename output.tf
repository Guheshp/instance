
/* output "keyname" {
    value = "${aws_key_pair.keypair_ec2.key_name}"
  
} */

output "aws_security_group" {

  value = aws_security_group.allow_sg.id

}

output "instanceid" {
    value = [
        aws_instance.grow.id ,
        aws_instance.grow.public_ip
    ]
}
