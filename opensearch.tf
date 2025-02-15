data "aws_caller_identity" "current" {}

resource "aws_opensearch_domain" "example_domain" {
  domain_name    = var.opensearch_domain_name
  engine_version = "OpenSearch_2.5"

  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1
    zone_awareness_enabled = false
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp2"
  }

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "AWS": "*" },
      "Action": "es:*",
      "Resource": "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.opensearch_domain_name}/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": [
            "${var.allowed_ip}"
          ]
        }
      }
    }
  ]
}
POLICY

  tags = {
    Name = var.opensearch_domain_name
  }
}
