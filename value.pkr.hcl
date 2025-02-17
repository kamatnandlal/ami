
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
  default = "ami-00264e664c8ba2d93"  # Replace with the latest CentOS 7 AMI ID
}

variable "ssh_username" {
  type    = string
  default = "centos"
}
