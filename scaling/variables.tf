variable "name" {
  type = string
}

variable "evaulation_periods" {
  type    = number
  default = 4
}

variable "namespace" {
  type    = string
  default = "AWS/EC2"
}

variable "period_down" {
  type    = number
  default = 120
}

variable "period_up" {
  type    = number
  default = 60
}

variable "statistic" {
  type    = string
  default = "Average"
}

variable "threshold_up" {
  type    = number
  default = 80
}

variable "threshold_down" {
  type    = number
  default = 30
}

variable "policy_type" {
  type    = string
  default = "SimpleScaling"
}

variable "cooldown_up" {
  type    = number
  default = 300
}


variable "cooldown_down" {
  type    = number
  default = 600
}

variable "adjustment_up" {
  type    = number
  default = 1
}

variable "adjustment_down" {
  type    = number
  default = -1
}

variable "num_asg" {
  type    = number
  default = 2
}

variable "autoscaling_group_name" {
  type = list(string)
}

variable "metric_name" {
  type    = string
  default = "CPUUtilization"
}

variable "adjustment_type" {
  type    = string
  default = "ChangeInCapacity"
}

variable "dimension_name" {
  type    = string
  default = "AutoScalingGroupName"
}

variable "dimension_value" {
  type    = string
  default = null
}

variable "datapoints_to_alarm_up" {
  type    = number
  default = null
}

variable "datapoints_to_alarm_down" {
  type    = number
  default = null
}