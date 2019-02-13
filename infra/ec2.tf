resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = "${var.pub_key}"
}

resource "aws_security_group" "allow_ingress_from_home" {
  name        = "allow-home"
  description = "Allow inbound traffic from my home IP"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.home_ip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo_instance" {
  ami                    = "ami-032509850cf9ee54e"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.my_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_ingress_from_home.id}"]

  tags = {
    Name = "demo-instance"
  }

  depends_on = ["aws_security_group.allow_ingress_from_home"]
}

output "instance_ips" {
  value = ["${aws_instance.demo_instance.*.public_ip}"]
}
