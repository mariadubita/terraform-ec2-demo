variable "aws_region" {
  type    = string
  default = "us-east-1"
  description = "AWS region for the deployment"
}

variable "allowed_ip" {
    type        = string
      description = "IP or IP range for OpenSearch access"
        default     = "0.0.0.0/0" 
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be created"
}

variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID for the EC2 instance"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name for SSH access"
}

variable "opensearch_domain_name" {
  type    = string
  default = "lab-os-domain"
  description = "Name of the OpenSearch domain"
}

variable "s3_bucket_name" {
  type    = string
  default = "my-lab-logs-bucket-unique-20250215"
  description = "S3 bucket for Lambda logs"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
  description = "EC2 instance size"
}
