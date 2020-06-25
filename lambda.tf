data template_file lambda {
  count    = length(var.cloudfront_aliases) > 0 ? 1 : 0
  template = "${file("${path.module}/index.js")}"

  vars = {
    primary_hostname = var.redirect_all ? "" : var.cloudfront_distribution
  }
}

data archive_file lambda {
  count                   = length(var.cloudfront_aliases) > 0 ? 1 : 0
  type                    = "zip"
  output_path             = "${path.module}/dist/lambda.zip"
  source_content          = data.template_file.lambda[0].rendered
  source_content_filename = "index.js"
}

resource aws_lambda_function lambda {
  count            = length(var.cloudfront_aliases) > 0 ? 1 : 0
  provider         = aws.us-east-1
  filename         = data.archive_file.lambda[0].output_path
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda[0].arn
  handler          = "index.handler"
  runtime          = "nodejs10.x"
  publish          = true
  source_code_hash = data.archive_file.lambda[0].output_base64sha256

  tags = var.tags
}

resource aws_cloudwatch_log_group logs {
  count             = length(var.cloudfront_aliases) > 0 ? 1 : 0
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7
  tags              = var.tags
}

data aws_iam_policy_document lambda_assume_role {
  count = length(var.cloudfront_aliases) > 0 ? 1 : 0
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com",
      ]
    }

    effect = "Allow"
  }
}

resource aws_iam_role lambda {
  count              = length(var.cloudfront_aliases) > 0 ? 1 : 0
  name               = "LambdaRole-${var.lambda_function_name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role[0].json
}

resource aws_iam_role_policy_attachment lambda_log_access {
  count      = length(var.cloudfront_aliases) > 0 ? 1 : 0
  role       = aws_iam_role.lambda[0].name
  policy_arn = aws_iam_policy.lambda_log_access[0].arn
}

data aws_iam_policy_document lambda_log_access {
  count = length(var.cloudfront_aliases) > 0 ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "lambda_log_access" {
  count  = length(var.cloudfront_aliases) > 0 ? 1 : 0
  name   = "LambdaLogAccess-${var.lambda_function_name}"
  policy = data.aws_iam_policy_document.lambda_log_access[0].json
}
