# Main Repository

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/39a93283d66f421fb3b5109a83772119)](https://app.codacy.com/gh/noahtkeller/home-develop?utm_source=github.com&utm_medium=referral&utm_content=noahtkeller/home-develop&utm_campaign=Badge_Grade_Settings)

This is the parent repository for my personal learning projects, the confluence of the different technologies
used to power my website. The purposes of all of these repositories is for my to learn best practices, 
sharpen my skills, to be a reference for future work, and to act as an evolving portfolio and résumé.

## Technologies In Use

Talk about how I use each of these technologies in this stack

#### Angular
#### Ansible

#### AWS
All the back-end services will be hosted in AWS or some other cloud provider for the time being.

#### C++
#### CentOS

#### cloud-init
Cloud-init data is stored in the `ci-data` folder and can be generated with the make task `generate-ci-data`
More details to come soon.

```bash
make generate-ci-data
```

#### Docker
#### Go
#### gRPC
#### InSpec
#### Mocha
#### NodeJS

#### Packer
I use Packer to create the golden images for all the various machines that I need.
I use [Ansible](https://www.ansible.com/) for the configuration and [InSpec](https://docs.chef.io/inspec/) to test
the images to ensure they are correctly setup.

#### Protobuf
#### Python

#### QEMU
I don't currently have a home lab setup, so I won't be doing much with Qemu until then. However, I have started
here just to lear about how to use preseeds and cloud images.

#### Ruby
#### Rust
#### Terraform
#### TypeScript
#### Ubuntu
#### Vue.js
#### WASM

## Documentation
Certainly my least favorite part of software development life cycle, but arguably the most important: documentation!
It might not be as obvious as some other things outlined here but part of the goal here is to improve my ability
to document the code that I write, and also the fact that there really isn't much purpose to this website beyond
documenting the technology that drives it.

## GitHub Pages
My GitHub Pages repos are in this container in two parts:

1. Source: [code/front-end/github-io](https://github.com/noahtkeller/github-io)<br/>
   The non-compiled source code for the static site
2. Build: [github-io](https://github.com/noahtkeller/noahtkeller.github.io)<br/>
   The compiled files are in the top-level github-io folder. This repo should not be modified directly it only houses
   the built files from the source repo above.

## SMTP
Mention MXGuard Dog

## VoIP.ms
Mention VOIP setup
