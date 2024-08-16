output "frontend_bucket_name" {
  value = aws_s3_bucket.frontend_bucket.bucket
}

output "api_gateway_id" {
  value = aws_api_gateway_rest_api.api_gateway.id
}

output "rds_endpoint" {
  value = aws_db_instance.rds_database.endpoint
}

output "sns_topic_arn" {
  value = aws_sns_topic.sns_topic.arn
}
