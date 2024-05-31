module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

output "bucket_arn" {
  value = module.s3.static_app_bucket_arn
}