# Generates an archive from content, a file, or a directory of files.

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python_lambda_function/"
  output_path = "${path.module}/python_lambda_function/script.zip"
}