resource "aws_instance" "test_instance" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance_type
  key_name = "ashvini"
  tags = {
    Name = "Jenkins-Ashvini"
  }
}