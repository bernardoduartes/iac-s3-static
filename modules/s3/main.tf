resource "aws_s3_bucket" "static_app_bucket" {
    bucket = "${var.bucket_name}-static-bucket"
    force_destroy = true

    tags = {
        Name        = "Static bucker for mybday website"
        Environment = "Dev"
  }
}

#Giving public acess
resource "aws_s3_bucket_public_access_block" "static_app_bucket_access_block" {
  bucket = aws_s3_bucket.static_app_bucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "static_app_bucket_ownership_controls" {
  bucket = aws_s3_bucket.static_app_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Attatcher public read alc
resource "aws_s3_bucket_acl" "static_app_bucket_acl" {
  bucket = aws_s3_bucket.static_app_bucket.id
  acl = "public-read"

  depends_on = [ 
    aws_s3_bucket_public_access_block.static_app_bucket_access_block,
    aws_s3_bucket_ownership_controls.static_app_bucket_ownership_controls,
   ]
}