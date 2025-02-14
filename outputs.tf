output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "opensearch_endpoint" {
  description = "Endpoint of the OpenSearch domain"
  value       = aws_opensearch_domain.example_domain.endpoint
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.ec2_status_logger.function_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.lambda_logs_bucket.bucket
}
