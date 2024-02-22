# Define provider
provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}
locals {
    vpc_id = "vpc-0cf188b8d9cf5a2f5"
    subnet_id = "subnet-04389578ba1930e53"
    private_key_path = "./one-click-keypair.pem"
}

# Create security group
resource "aws_security_group" "my_security_group" {
  name = "my_security_group"
  vpc_id = "vpc-0cf188b8d9cf5a2f5"

  # Allow SSH (port 22) and all traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 instance
resource "aws_instance" "httpd_server" {
  ami           = "ami-0cf10cdf9fcd62d37"
  subnet_id = "subnet-04389578ba1930e53"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  security_groups = [aws_security_group.my_security_group.id]
  key_name      = "one-click-keypair"
  tags = {
    Name = "HTTPD SERVER"
  }
  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]
    connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = file("/home/ec2-user/one-click-keypair")
        host        = self.public_ip
    }
  }

 provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.httpd_server.public_ip}, --private-key ${"/home/ec2-user/one-click-keypair"} httpd.yaml"
 }
}

output "httpd_server_ip" {
    value = aws_instance.httpd_server.public_ip
}
