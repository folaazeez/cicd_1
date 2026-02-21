variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "policy_gate_image" {
  type        = string
  description = "Container image URI for policy-gate (including tag)"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev/staging/prod)"
  default     = "dev"
}

variable "replica_count" {
  type        = number
  description = "Number of ECS service tasks"
  default     = 1
}