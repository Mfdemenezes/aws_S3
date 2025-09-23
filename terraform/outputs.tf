# ======================
# OUTPUTS DO BUCKET S3
# ======================

output "bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.main_bucket.bucket
}

output "bucket_arn" {
  description = "ARN do bucket S3"
  value       = aws_s3_bucket.main_bucket.arn
}

output "bucket_domain_name" {
  description = "Domain name do bucket S3"
  value       = aws_s3_bucket.main_bucket.bucket_domain_name
}

output "bucket_id" {
  description = "ID do bucket S3"
  value       = aws_s3_bucket.main_bucket.id
}

output "bucket_region" {
  description = "Região do bucket S3"
  value       = aws_s3_bucket.main_bucket.region
}

output "bucket_suffix" {
  description = "Sufixo aleatório usado no bucket"
  value       = random_string.bucket_suffix.result
}

# ======================
# INFORMAÇÕES DE RESUMO
# ======================

output "bucket_summary" {
  description = "Resumo do bucket criado"
  value = {
    name         = aws_s3_bucket.main_bucket.bucket
    arn          = aws_s3_bucket.main_bucket.arn
    region       = aws_s3_bucket.main_bucket.region
    encrypted    = true
    versioning   = var.enable_versioning ? "Enabled" : "Disabled"
    lifecycle    = var.lifecycle_enabled ? "Enabled" : "Disabled"
    public_read  = false
    public_write = false
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