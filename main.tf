# Lambda function resource
resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python_lambda_function/script.zip"
  function_name = "Python-Lambda-Function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "script.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_policy_attachment.lambda_policy_attachment]

  tracing_config {
    mode = "Active"
  }
}