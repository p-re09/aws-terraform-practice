variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-2" # London region
}

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "cloud-practice"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID, eu-west-2"
  type        = string
  default     = "ami-06f9e3b45a89cf4aa"
}

variable "key_pair_name" {
  description = "EC2 key pair used for SSH access to the instance"
  type        = string
}

variable "my_ip_cidr" {
  description = "Public IP address, in CIDR notation, permitted to SSH into the instance"
  type        = string
}
