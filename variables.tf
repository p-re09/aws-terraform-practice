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
  default     = "ami-0c1c30571d2dae5c9"
}

variable "key_pair_name" {
  description = "EC2 key pair used for SSH access to the instance"
  type        = string
}

variable "my_ip_cidr" {
  description = "Public IP address, in CIDR notation, permitted to SSH into the instance"
  type        = string
}
