# value.pkr.hcl
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "source_ami" {
  type    = string
  default = "ami-0d1d87e524772b453"
}

variable "ssh_username" {
  type    = string
  default = "centos"
}
# main.pkr.hcl
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "centos" {
  ami_name        = "centos-ami-{{timestamp}}"
  instance_type   = var.instance_type
  region          = var.region
  source_ami      = var.source_ami
  ssh_username    = var.ssh_username
  ssh_timeout     = "30m"
  tags = {
    Name        = "CentOS-AMI"
    Environment = "Production"
  }

}

build {
  sources = ["source.amazon-ebs.centos"]

  provisioner "shell" {
    script = "mango.sh"
  }

  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
  }
}
