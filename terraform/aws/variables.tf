variable "region" {
  type = string
  default = "us-east-1"
}

variable "default-availability-zone" {
  type = string
  default = "us-east-1f"
}

data aws_ami ubuntu-amd64-httpd {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu-amd64-httpd"]
  }

  owners = ["self"]
}
