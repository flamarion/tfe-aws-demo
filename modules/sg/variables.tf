variable "sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "tfe-sg"
}

variable "sg_desc" {
  description = "Security Group Description"
  type        = string
  default     = "Security Group"
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "tags" {
  description = "Security Group tag map"
  type        = map(string)
  default = {
    Name = "tfe"
  }
}

variable "source_sgid_rule" {
  description = "Enable Source as Security Group ID"
  type        = string
  default     = "disabled"
}

variable "sg_rules_cidr" {
  description = "Security group rules"
  type = map(object({
    description = string
    type        = string
    from_port   = number
    to_port     = number
    cidr_blocks = list(string)
    protocol    = string
    sg_id       = string
  }))
  default = {
    ssh = {
      description = "Terraform Cloud application via HTTP"
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = -1
      sg_id       = "default"
    }
  }
}

variable "sg_rules_sgid" {
  description = "Security group rules"
  type = map(object({
    description = string
    type        = string
    from_port   = number
    to_port     = number
    source_sgid = string
    protocol    = string
    sg_id       = string
  }))
  default = {
    ssh = {
      description = "Terraform Cloud application via HTTP"
      type        = "ingress"
      source_sgid = "default"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      sg_id       = "default"
    }
  }
}
