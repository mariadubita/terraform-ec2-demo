resource "random_string" "suffix" {
    length  = 8
    upper   = false
    lower   = true
    numeric = true
    special = false
}

resource "aws_s3_bucket" "lambda_logs_bucket" {
  bucket = "lab-s3-bucket-${random_string.suffix.result}"

  tags = {
    Name = "lab-s3-bucket-${random_string.suffix.result}"
  }
}

resource "aws_s3_bucket_public_access_block" "lambda_logs_bucket_block" {
  bucket = aws_s3_bucket.lambda_logs_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

