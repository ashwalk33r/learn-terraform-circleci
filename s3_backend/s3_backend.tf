terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "random_uuid" "randomid" {}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${random_uuid.randomid.result}-backend"
  force_destroy = true
  versioning {
    enabled = false
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}
