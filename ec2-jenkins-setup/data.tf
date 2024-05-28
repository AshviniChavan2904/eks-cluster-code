data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240411"]
  }
}

data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = ["explorers-dev-vpc"]
  }
}
data "aws_subnet" "my_subnet" {
  filter {
    name   = "tag:Name"
    values = ["explorers-dev-subnet-public2-us-east-1b"]
  }
}