# value.pkr.hcl

variable "vpc_id" {
  type    = string
  default = "vpc-0b1295ad659c4388e"  
}

variable "subnet_id" {
  type    = string
  default = "subnet-0d464670309d7fe52" 
}

variable "security_group_id" {
  type    = string
  default = "sg-05636b1f51c5e0f40"  
}

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
  vpc_id          = var.vpc_id
  subnet_id       = var.subnet_id 
  security_group_id = var.security_group_id 
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
