variable "lambda_function_name" {
  type = string
}

variable "lambda_handler" {
  type    = string
  default = "index.handler"
}

variable "lambda_runtime" {
  type    = string
  default = "python3.9"
}

variable "lambda_role_arn" {
  type = string
}

variable "target_bucket" {
  type = string
}

variable "lambda_source" {
  description = "Path to the Lambda Python file"
  type        = string
}
