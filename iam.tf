# .deploy/terraform/static-site/iam.tf
# https://stackoverflow.com/questions/50389962/allow-cloudfront-to-access-an-s3-bucket-with-an-origin-access-identity
data "aws_iam_policy_document" "dependencies_policy" {
  statement {
    actions = [
      "*"
    ]
    effect = "Allow"
    principals {
#      identifiers = ["*"]
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
#      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
#      "AWS": aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
    }
    resources = [
#      "arn:aws:s3:::${aws_s3_bucket.dependencies_bucket.id}/*",
      "arn:aws:s3:::${var.name}-${var.environment}/*"
    ]
  }
}
