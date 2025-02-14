data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lab-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = {
    Name = "lab-lambda-role"
  }
}

data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "${aws_s3_bucket.lambda_logs_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lab-lambda-ec2-s3-policy"
  policy = data.aws_iam_policy_document.lambda_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
