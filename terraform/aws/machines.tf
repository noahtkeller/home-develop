resource aws_instance focal-httpd-0 {
  subnet_id = aws_subnet.primary_subnet.id
  ami = data.aws_ami.httpd-focal-amd64.id
  instance_type = "t2.small"
  associate_public_ip_address = true
  private_ip = "10.0.0.5"

  tags = {
    Name = "focal-httpd-0"
  }
}
