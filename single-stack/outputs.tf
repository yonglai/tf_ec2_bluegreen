output "asg_id" {
  value = aws_autoscaling_group.bluegreen_asg.id
}

output "nonbinding_asg_name" {
  value = local.asg_name
}