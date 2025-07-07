variable "function_name" {}
variable "role_arn" {}
variable "handler" {}
variable "runtime" {}
variable "filename" {}
variable "environment_variables" {
  type    = map(string)
  default = {}
}
variable "project" {
  default = "shared-lambda"
}
