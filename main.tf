resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action   = "sts:AssumeRole",
        Effect   = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "cloudwatch_full_access_attachment" {
  name       = "cloudwatch_full_access_attachment"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  roles      = [aws_iam_role.lambda_role.name]
}

# Lambda function
resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python_lambda_function/script.zip"
  function_name = "Python-Lambda-Function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "script.lambda_handler"
  runtime       = "python3.8"
  depends_on    = [aws_iam_policy_attachment.cloudwatch_full_access_attachment]

  tracing_config {
    mode = "Active"
  }
}
