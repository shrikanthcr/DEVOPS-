resource "aws_instance" "ec2terrafrom" {
  ami           = "ami-094bbd9e922dc515d"
  instance_type = "t2.micro"
  key_name = "vinod_devops"
  user_data     = file("htppd.sh")
  security_groups = ["vinod_demo_security"]
  count = 2
  tags ={
  Name = "my_terraform_htppd"
  }
}
