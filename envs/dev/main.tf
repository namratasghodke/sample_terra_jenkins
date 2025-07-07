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