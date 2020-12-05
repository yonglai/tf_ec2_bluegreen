variable "name" {
  type = string
}

variable "blue_max_size" {
  type = number
}

variable "blue_min_size" {
  type = number
}

variable "blue_desired_capacity" {
  type = number
}

variable "blue_instance_type" {
  type = string
}

variable "blue_ami" {
  type = string
}

variable "blue_user_data" {
  type    = string
  default = "# Hello World"
}

variable "blue_disk_volume_size" {
  type    = number
  default = 8
}

variable "blue_disk_volume_type" {
  type    = string
  default = "gp2"
}

variable "green_max_size" {
  type = number
}

variable "green_min_size" {
  type = number
}

variable "green_desired_capacity" {
  type = number
}

variable "green_instance_type" {
  type = string
}

variable "green_ami" {
  type = string
}

variable "green_user_data" {
  type    = string
  default = "# Hello World"
}

variable "green_disk_volume_size" {
  type    = number
  default = 8
}

variable "green_disk_volume_type" {
  type    = string
  default = "gp2"
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

variable "subnets" {
  type    = list(string)
  default = []
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