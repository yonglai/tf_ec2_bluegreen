variable "color" {
  type        = string
  description = "Color of the Auto Scaling Group"
}

variable "name" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type    = string
  default = null
}

variable "loadbalancers" {
  type    = list(string)
  default = []
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "iam_instance_profile" {
  type    = string
  default = null
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "user_data" {
  type    = string
  default = "# Hello World"
}

variable "disk_volume_size" {
  type    = number
  default = 8
}

variable "disk_volume_type" {
  type    = string
  default = "gp2"
}

variable "subnets" {
  type    = list(string)
  default = []
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "health_check_grace_period" {
  type    = number
  default = 300
}

variable "termination_policies" {
  type    = list(string)
  default = ["Default"]
}

variable "target_group_arns" {
  type    = list(string)
  default = []
}

variable "health_check_type" {
  type    = string
  default = "ELB"
}

variable "tags" {
  type    = list(map(string))
  default = []
}

variable "spot_price" {
  type    = string
  default = null
}

variable "wait_for_capacity_timeout" {
  type    = string
  default = "10m"
}

variable "initial_lifecycle_hooks" {
  type    = list(map(string))
  default = []
}