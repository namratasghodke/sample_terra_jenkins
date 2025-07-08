output "lambda_role_arn" {
  description = "IAM Role ARN for Lambda"
  value       = aws_iam_role.lambda_exec_role.arn
}

output "lambda_role_name" {
  description = "IAM Role Name for Lambda"
  value       = aws_iam_role.lambda_exec_role.name
}