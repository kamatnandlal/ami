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
  default = "ami-0affd4508a5d2481b"  # Replace with the latest CentOS 7 AMI ID
}

variable "ssh_username" {
  type    = string
  default = "centos"
}
