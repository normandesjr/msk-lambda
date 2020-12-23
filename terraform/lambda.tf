data "aws_s3_bucket" "bucket_lambda" {
  bucket = "iti-zup"
}

data archive_file msk_consumer_zip {
  type        = "zip"
  source_dir  = "${path.module}/lambda/msk-consumer/"
  output_path = "${path.module}/lambda/msk-consumer.zip"
}

module lambda_authorizer_role {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  role_name         = "LambdaAuthorizer"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaMSKExecutionRole"
  ]

  create_role       = true
  role_requires_mfa = false
}

module lambda_msk_consumer {
  source  = "terraform-module/lambda/aws"
  function_name  = "ItiZupConsumerMsk"
  filename       = data.archive_file.msk_consumer_zip.output_path
  description    = "Consumidor do MSK"
  handler        = "index.handler"
  runtime        = "nodejs12.x"
  lambda_timeout = "20"
  concurrency    = "10"
  memory_size    = "128"
  role_arn       = module.lambda_authorizer_role.this_iam_role_arn
}
