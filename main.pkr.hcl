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
  ssh_timeout     = "10m"
  tags = {
    Name        = "CentOS-AMI"
    Environment = "Production"
  }
  access_key = "${env("AWS_ACCESS_KEY_ID")}"
  secret_key = "${env("AWS_SECRET_ACCESS_KEY")}"
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
