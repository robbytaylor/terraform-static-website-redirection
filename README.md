# Terraform S3 Website with redirection

This Terraform module creates a static website with S3 and CloudFront
with the addition of a Lambda@Edge function to redirect to the primary hostname.

This is useful is you have multiple domains or subdomains referencing the website
and want to ensure that users are redirected to the preferred domain.
