# IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

# IAM policy for Lambda function
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  description = "IAM policy for Lambda function"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableCreationAndManagementOfLambdaCloudwatchLogEvents"
        Effect = "Allow"
        Action = [
          "logs:GetLogEvents",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:log-group:/aws/lambda/*"
      },
      {
        Sid    = "EnableCreationAndManagementOfLambdaCloudwatchLogGroupsAndStreams"
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:DescribeLogStreams",
          "logs:PutRetentionPolicy",
          "logs:CreateLogGroup"
        ]
        Resource = "arn:aws:logs:*:*:log-group:/aws/lambda/*:*"
      }
    ]
  })
}

# IAM policy attachment for Lambda function to CloudWatch access policy
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "cloudwatch_access_attachment"
  policy_arn = aws_iam_policy.lambda_policy.arn
  roles      = [aws_iam_role.lambda_role.name]
}
