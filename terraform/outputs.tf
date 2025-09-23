# ======================
# OUTPUTS DOS BUCKETS S3
# ======================

output "main_bucket_name" {
  description = "Nome do bucket principal"
  value       = aws_s3_bucket.main_bucket.bucket
}

output "main_bucket_arn" {
  description = "ARN do bucket principal"
  value       = aws_s3_bucket.main_bucket.arn
}

output "main_bucket_domain_name" {
  description = "Domain name do bucket principal"
  value       = aws_s3_bucket.main_bucket.bucket_domain_name
}

output "logs_bucket_name" {
  description = "Nome do bucket de logs"
  value       = aws_s3_bucket.logs_bucket.bucket
}

output "logs_bucket_arn" {
  description = "ARN do bucket de logs"
  value       = aws_s3_bucket.logs_bucket.arn
}

output "bucket_suffix" {
  description = "Sufixo aleatório usado nos buckets"
  value       = random_string.bucket_suffix.result
}

# ======================
# INFORMAÇÕES DE RESUMO
# ======================

output "buckets_summary" {
  description = "Resumo dos buckets criados"
  value = {
    main_bucket = {
      name       = aws_s3_bucket.main_bucket.bucket
      arn        = aws_s3_bucket.main_bucket.arn
      region     = aws_s3_bucket.main_bucket.region
      encrypted  = true
      versioning = "Enabled"
    }
    logs_bucket = {
      name       = aws_s3_bucket.logs_bucket.bucket
      arn        = aws_s3_bucket.logs_bucket.arn
      region     = aws_s3_bucket.logs_bucket.region
      encrypted  = true
      versioning = "Enabled"
    }
  }
}

output "project_info" {
  description = "Informações do projeto"
  value = {
    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region
  }
}