output bucket_arn {
  value = aws_s3_bucket.bucket.arn
}

output bucket_name {
  value = aws_s3_bucket.bucket.bucket
}

output cloudfront_zone_id {
  value = aws_cloudfront_distribution.default.hosted_zone_id
}

output cloudfront_domain_name {
  value = aws_cloudfront_distribution.default.domain_name
}
