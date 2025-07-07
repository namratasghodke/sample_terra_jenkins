variable "role_name" {}
variable "bucket_name" {}
variable "region" {}
variable "account_id" {}
variable "secrets_arns" {
  type = list(string)
}