resource "aws_instance" "ec2terraform" {
  ami           = "ami-0866a04d72a1f5479"
  instance_type = "t2.large"
  key_name = "ohiokey"
  user_data     = file("nexus.sh")
  security_groups = ["My_Security_Group1"]
  count = 1
  tags ={
  Name = "my_terraform_nexus"
  }
}
