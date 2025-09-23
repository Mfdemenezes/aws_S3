# ======================
# S3 BUCKET COM CRIPTOGRAFIA
# ======================

# Bucket principal de dados
resource "aws_s3_bucket" "main_bucket" {
  bucket = "${var.project_name}-${var.environment}-${random_string.bucket_suffix.result}"

  tags = {
    Name        = "${var.project_name}-main-bucket"
    Environment = var.environment
    Purpose     = "Main data storage"
  }
}

# Sufixo aleatório para garantir nomes únicos
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# ======================
# CRIPTOGRAFIA DO BUCKET
# ======================

# Criptografia do bucket principal
resource "aws_s3_bucket_server_side_encryption_configuration" "main_bucket" {
  bucket = aws_s3_bucket.main_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# ======================
# CONFIGURAÇÕES DE SEGURANÇA
# ======================

# Bloquear acesso público no bucket principal
resource "aws_s3_bucket_public_access_block" "main_bucket" {
  bucket = aws_s3_bucket.main_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ======================
# VERSIONAMENTO
# ======================

# Versionamento do bucket principal
resource "aws_s3_bucket_versioning" "main_bucket" {
  bucket = aws_s3_bucket.main_bucket.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}

# ======================
# LIFECYCLE RULES
# ======================

# Regras de ciclo de vida para o bucket principal
resource "aws_s3_bucket_lifecycle_configuration" "main_bucket" {
  count  = var.lifecycle_enabled ? 1 : 0
  bucket = aws_s3_bucket.main_bucket.id

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = var.days_to_ia
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.days_to_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.days_to_expire
    }
  }

  rule {
    id     = "delete_old_versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}