variable "aws_region" {
  description = "AWS region where resources are creaed."
  type        = string
}

variable "task_id" {
  description = "unique task identifier used as the ID tag and as the prefix for resources"
  type        = string
}

variable "project" {
  description = "value for the projecy tag."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "ssh_key" {
  description = "provides custom public SSH key."
  type        = string
}
