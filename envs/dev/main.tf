module "ec2_instance_app" {
  source             = "../../modules/ec2"
  ami_id             = "ami-05ffe3c48a9991133"
  instance_type      = "t3.micro"
  key_name           = "as"
  subnet_id          = "subnet-08e1369861115aba1"
  security_group_ids = ["sg-045df96b28d7c4bf4"]
  instance_name      = "dev-ec2-instance"
  environment        = "dev"
}
module "ec2_instance_Jenkins" {
  source             = "../../modules/ec2"
  ami_id             = "ami-05ffe3c48a9991133"
  instance_type      = "t3.micro"
  key_name           = "as"
  subnet_id          = "subnet-08e1369861115aba1"
  security_group_ids = ["sg-045df96b28d7c4bf4"]
  instance_name      = "dev-ec2-instance-jenkins"
  environment        = "dev"
}
module "s3_bucket_artifacts" {
  source      = "../../modules/s3"
  bucket_name = "dev-mlops-artifacts-bucket-001"
  environment = "dev"
}
provider "aws" {
  region = "us-east-1"
}

module "lambda_code_bucket" {
  source      = "../../modules/s3"
  bucket_name = "lambda-code-bucket-dev"
}

module "lambda_output_bucket" {
  source      = "../../modules/s3"
  bucket_name = "lambda-output-bucket-dev"
}

module "iam" {
  source         = "../../modules/iam"
  iam_role_name  = "lambda-role-dev"
  target_bucket  = module.lambda_output_bucket.bucket_name
}

module "lambda" {
  source                = "../../modules/lambda"
  lambda_function_name  = "lambda-download-save"
  lambda_handler        = "index.handler"
  lambda_runtime        = "python3.9"
  lambda_role_arn       = module.iam.lambda_role_arn
  lambda_source         = "${path.module}/index.py"
  target_bucket         = module.lambda_output_bucket.bucket_name
}