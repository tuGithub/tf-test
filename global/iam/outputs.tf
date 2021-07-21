/*
output "all_users" {
  value = aws_iam_user.example
}
*/

output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}

output "short_upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}