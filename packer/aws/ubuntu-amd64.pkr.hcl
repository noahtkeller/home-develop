variable canonical-account-id {
  type = string
    default = "099720109477"
}

variable "ubuntu-server-release" {
  type = string
  default = "focal"
}

source amazon-ebs ubuntu-base-amd64 {
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name = "ubuntu/images/*ubuntu-${var.ubuntu-server-release}-*-amd64-server-*"
      root-device-type = "ebs"
    }
    owners = [var.canonical-account-id]
    most_recent = true
  }
  ami_description = "Ubuntu ${var.ubuntu-server-release} server amd64 golden image"
  ssh_username = "ubuntu"
  iam_instance_profile = "packer-builder"
}

build {
  source "amazon-ebs.ubuntu-base-amd64" {
    ami_name = "ubuntu-${var.ubuntu-server-release}-amd64"
    associate_public_ip_address = "true"
    ami_virtualization_type = "hvm"
    instance_type = "t2.small"
    region = "us-east-1"
    name = "ubuntu-amd64"
  }

  provisioner ansible {
    playbook_file = "ansible/plays/ubuntu_server.yml"
    galaxy_file = "ansible/roles/roles_requirements.yml"
    roles_path = "ansible/roles/external"
    ansible_env_vars = ["ANSIBLE_CONFIG=ansible/plays/ansible.cfg"]
  }

  provisioner inspec {
    inspec_env_vars = ["CHEF_LICENSE=accept"]
    profile = "https://github.com/dev-sec/linux-baseline/archive/refs/tags/2.6.0.tar.gz"
  }
}
