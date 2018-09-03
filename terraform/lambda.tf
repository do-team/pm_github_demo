resource "aws_lambda_function" "listme" {
  
  function_name    = "mylambda"
  role             = "${aws_iam_role.listme_lambda.arn}"
  handler          = "index.handler"
  s3_bucket        = "${var.OPS_BUCKET}"
  s3_key           = "mylambda.zip"
  source_code_hash = "${timestamp()}" // Enforcing deployment every time.
  runtime          = "nodejs8.10"
  timeout          = "5"
  memory_size      = "1536"

  environment {
    variables = {
      SLACK_SECRET_NAME = "${aws_secretsmanager_secret.slacksecret.name}"
    }
  }

  tags {
    Environment = "Production"
  }
}
