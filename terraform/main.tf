provider "aws" {
  region = "us-east-1"  # Substitua pela região desejada
}

# 1. Bucket S3
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "petshop-frontend-bucket"  # Certifique-se de que o nome seja único
}

# 2. API Gateway
resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "petshop-api"
  description = "API Gateway for Pet Shop"
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part    = "v1"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "GET"
  authorization = "NONE"
}

# 3. EC2 Instance
resource "aws_instance" "backend_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Substitua pelo AMI desejado
  instance_type = "t2.micro"

  tags = {
    Name = "PetShopBackend"
  }
}

# 4. Lambda Functions
resource "aws_lambda_function" "image_processing_lambda" {
  filename         = "lambda_image_processing.zip"  # Caminho para o pacote de implantação
  function_name    = "image_processing_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256("lambda_image_processing.zip")
  runtime          = "nodejs14.x"  # Substitua pelo runtime desejado
}

resource "aws_lambda_function" "notification_lambda" {
  filename         = "lambda_notification.zip"  # Caminho para o pacote de implantação
  function_name    = "notification_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256("lambda_notification.zip")
  runtime          = "nodejs14.x"  # Substitua pelo runtime desejado
}

# 5. RDS Database
resource "aws_db_instance" "rds_database" {
  identifier        = "petshop-db"
  instance_class    = "db.t2.micro"
  engine            = "mysql"
  username          = "admin"
  password          = "password"  # Substitua por uma senha segura
  db_name           = "petshopdb"
  allocated_storage = 20

  tags = {
    Name = "PetShopDatabase"
  }
}

# 6. SNS Topic
resource "aws_sns_topic" "sns_topic" {
  name = "petshop-sns-topic"
}

# 7. CloudWatch Logs
resource "aws_cloudwatch_log_group" "cloudwatch_logs" {
  name = "petshop-cloudwatch-logs"
}

# 8. IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# 9. IAM Policy Attachment for Lambda
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
