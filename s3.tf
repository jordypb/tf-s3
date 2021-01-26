resource "aws_s3_bucket" "dependencies_bucket" {
  bucket = "${var.name}-${var.environment}"
  acl = "private"
  policy = data.aws_iam_policy_document.dependencies_policy.json
  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true
#  website {
#    index_document = "index.html"
#    error_document = "index.html"
#  }
  tags = {
    environment = var.environment
  }
}

resource "aws_s3_bucket_object" "object_lambda-ingess-stocks" {
  bucket = aws_s3_bucket.dependencies_bucket.bucket
  key    = "lambda-ingess-stocks.zip"
  source = "package.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
#  etag = filemd5("path/to/file")
}
