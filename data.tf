# Generates an archive from the source code, which can then be uploaded to Lambda
data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python_lambda_function/"
  output_path = "${path.module}/python_lambda_function/script.zip"
}