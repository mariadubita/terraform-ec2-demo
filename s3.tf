resource "aws_s3_bucket" "lambda_logs_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name = var.s3_bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "lambda_logs_bucket_block" {
  bucket = aws_s3_bucket.lambda_logs_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "lambda_logs_bucket_acl" {
  bucket = aws_s3_bucket.lambda_logs_bucket.id
  acl    = "private"
}
