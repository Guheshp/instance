
data "aws_ami" "ubuntu" {
     most_recent      = true
      owners           = ["099720109477"]

    filter {
      name = "name"
      values = ["${var.image_name}"]
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

#aws instance ----------------
resource "aws_instance" "grow" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = var.instance_type
  key_name        = var.keypairs
  vpc_security_group_ids = [ "${aws_security_group.allow_sg.id}" ]
  tags = {
    name = "terraform-instance"
  }

  #user_data = file("${path.module}/script.sh")

#provisoner connection filr , remote_exec , local_exec
  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/id_rsa")
      host = "${self.public_ip}"
    }
  provisioner "file" {
    source = "README.md"
    destination = "/tmp/README.md"
    }
  provisioner "file" {
   content = "creating another provisioner in grow instance  "
    destination = "/tmp/content1.md"
  }
  provisioner "file" {
   content = "creating another provisioner in grow instance  "
    destination = "/tmp/content2.md"
  }
  provisioner "local-exec" {
   command = "echo ${self.public_ip} > /tmp/public.txt"
  }

  provisioner "local-exec" {
   command = "echo 'at create'"
  }

  provisioner "local-exec" {
    when = destroy
   command = "echo 'at delete'"
  }

  provisioner "local-exec" {
   command = "env>env.txt"
   environment = {
     envname = "envalue"
   }
  }

  provisioner "local-exec" {
   working_dir = "/tmp"
    command = "echo ${self.private_ip} > private.txt" 
  }
  provisioner "local-exec" {
    interpreter = [ 
      "/Library/Frameworks/Python.framework/Versions/3.10/bin/python3" , "-c"
     ]
    command = "print('sunshine')"

  }

  /* provisioner "remote-exec" {
    inline = [
       "ifconfig > /tmp/ifconfig.output",
       "echo 'sunshine'  > /tmp/example.txt" 
     ]
  }
  provisioner "remote-exec" {
    script = "./testscript.sh"
    
  }
   provisioner "remote-exec" {
    script = "./another.sh"
    
  } */
}