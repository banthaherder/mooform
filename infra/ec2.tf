resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = "${var.pub_key}"
}

resource "aws_instance" "web" {
  ami           = "ami-032509850cf9ee54e"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
  }
}

output "instance_ips" {
  value = ["${aws_instance.web.*.public_ip}"]
}
