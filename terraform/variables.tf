variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1" 
}

variable "vpc_cidr" {
  description = "CIDR block for the custom VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "key_name" {
  description = "Name of the existing AWS SSH key pair"
  type        = string
  default     = "RandomStringAppKey" 
}