resource "aws_lambda_function" "ec2_status_logger" {
  function_name = "ec2-status-logger"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename         = "${path.module}/lambda_code.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_code.zip")

  environment {
    variables = {
      INSTANCE_ID = aws_instance.web_server.id
      S3_BUCKET   = aws_s3_bucket.lambda_logs_bucket.bucket
    }
  }

  tags = {
    Name = "ec2-status-logger"
  }
}
