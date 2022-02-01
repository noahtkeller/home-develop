ubuntu=focal
ubuntu_cloud_image=$(ubuntu)-server-cloudimg-amd64.img
centos=7
centos_cloud_image=CentOS-$(centos)-x86_64-GenericCloud.qcow2

define userdata
debug: true
disable_root: true
users:
  - name: ${USER}
	shell: /bin/bash
	ssh_authorized_keys:
	  - ${PUBLIC_KEY}
endef
export userdata

generate-ci-data:
	@echo "Generating cloud-init data..."
	@echo "$$userdata" > ci-data/user-data
	@echo "Done"

qemu-ks-ubuntu-amd64:
	packer build \
		-var 'ubuntu-server-release=$(ubuntu)' \
		-var 'ubuntu-checksum=$(shell jq -r '."ubuntu-$(ubuntu)-ks-checksum"' checksums.json)' \
		-force \
		packer/qemu/ks/ubuntu-amd64.pkr.hcl

qemu-ci-ubuntu-amd64:
	packer build \
		-var 'ubuntu-server-release=$(ubuntu)' \
		-var 'ubuntu-checksum=$(shell jq -r '."ubuntu-$(ubuntu)-checksum"' checksums.json)' \
		-force \
		packer/qemu/ci/ubuntu-amd64.pkr.hcl

aws-ubuntu-amd64:
	packer build \
		-var 'ubuntu-server-release=$(ubuntu)' \
		-force \
		packer/aws/ubuntu-amd64.pkr.hcl

aws-ubuntu-amd64-httpd:
	packer build \
		-var 'ubuntu-server-release=$(ubuntu)' \
		-force \
		--only=amazon-ebs.ubuntu-amd64-httpd \
		packer/aws

download-ubuntu-cloud-image:
ifeq ($(shell test -f images/$(ubuntu_cloud_image) && echo "yes"),)
	@echo "images/$(ubuntu_cloud_image) does not exist locally, downloading..."
	@curl https://cloud-images.ubuntu.com/$(ubuntu)/current/$(ubuntu_cloud_image) -o images/$(ubuntu_cloud_image)
else ifneq ($(shell openssl sha256 images/$(ubuntu_cloud_image) | awk -F' ' '{ print $$2 }'), $(shell jq -r '."ubuntu-$(ubuntu)-checksum"' checksums.json))
	@echo "checksum does not match for $(ubuntu_cloud_image)"
	@echo "removing local copy"
	@rm images/$(ubuntu_cloud_image)
	@echo "downloading remote copy"
	@curl https://cloud-images.ubuntu.com/$(ubuntu)/current/$(ubuntu_cloud_image) -o images/$(ubuntu_cloud_image)
else
	@echo "$(ubuntu_cloud_image) exists locally and checksum matches"
endif

download-centos-cloud-image:
ifeq ($(shell test -f images/$(centos_cloud_image) && echo "yes"),)
	@echo "images/$(centos_cloud_image) does not exist locally, downloading..."
	@curl https://cloud.centos.org/centos/$(centos)/images/$(centos_cloud_image) -o images/$(centos_cloud_image)
else ifneq ($(shell openssl sha256 images/$(centos_cloud_image) | awk -F' ' '{ print $$2 }'), $(shell jq -r '."centos-$(centos)-checksum"' checksums.json))
	@echo "checksum does not match for $(centos_cloud_image)"
	@echo "removing local copy"
	@rm images/$(centos_cloud_image)
	@echo "downloading remote copy"
	@curl https://cloud.centos.org/centos/$(centos)/images/$(centos_cloud_image) -o images/$(centos_cloud_image)
else
	@echo "$(centos_cloud_image) exists locally and checksum matches"
endif
