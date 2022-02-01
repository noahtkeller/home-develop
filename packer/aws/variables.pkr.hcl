data amazon-ami ubuntu-amd64 {
  filters = {
    name = "ubuntu-${var.ubuntu-server-release}-amd64"
  }
  owners = ["self"]
  most_recent = true
}

source amazon-ebs ubuntu-amd64 {
  source_ami = data.amazon-ami.ubuntu-amd64.id
  associate_public_ip_address = "true"
  ami_virtualization_type = "hvm"
  ami_description = "The base updated ubuntu image for building all other systems"
  instance_type = "t2.small"
  region = "us-east-1"
  ssh_username = "ubuntu"
  ssh_interface = "session_manager"
  communicator = "ssh"
  iam_instance_profile = "packer-builder"
}
