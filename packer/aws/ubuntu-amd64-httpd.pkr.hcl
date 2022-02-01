build {
  source "amazon-ebs.ubuntu-amd64" {
    name = "ubuntu-amd64-httpd"
    ami_name = "ubuntu-${var.ubuntu-server-release}-amd64-httpd"
  }

  provisioner "ansible" {
    playbook_file = "ansible/plays/httpd_host.yml"
    galaxy_file = "ansible/roles/roles_requirements.yml"
    roles_path = "ansible/roles/external"
    ansible_env_vars = ["ANSIBLE_CONFIG=ansible/plays/ansible.cfg"]
  }

  provisioner inspec {
    inspec_env_vars = ["CHEF_LICENSE=accept"]
    profile = "packer/test/ubuntu-amd64-httpd"
  }
}
