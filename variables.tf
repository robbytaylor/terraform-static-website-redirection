variable cloudfront_acm_certificate_arn {
  description = "ACM Certificate ARN for Cloudfront"
}

variable cloudfront_distribution {
  type        = string
  description = "The cloudfront distribtion"
}

variable bucket_name {
  type        = string
  description = "The name of your s3 bucket"
}

variable region {
  type        = string
  description = "The region to deploy the S3 bucket into"
}

variable session_duration {
  type        = string
  default     = "1"
  description = "Session duration in hours"
}

variable tags {
  type        = map
  default     = {}
  description = "Tags to label resources with"
}

variable cloudfront_aliases {
  type        = list
  default     = []
  description = "List of FQDNs to be used as alternative domain names (CNAMES) for Cloudfront"
}

variable cloudfront_default_root_object {
  type        = string
  default     = "index.html"
  description = "The default root object of the Cloudfront distribution"
}

variable cloudfront_error_responses {
  type    = list
  default = []
}

variable cloudfront_price_class {
  type        = string
  default     = "PriceClass_All"
  description = "Cloudfront price classes: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable lambda_function_name {
  type        = string
  default     = "cloudfront-redirect"
  description = "The name of the Lambda@Edge function for redirecting to the primary hostname"
}

variable redirect_all {
  type        = bool
  default     = false
  description = "Whether all requests should be redirected, or just ones which don't match the CloudFront distribution primary host"
}
