# ======================
# S3 BUCKETS COM CRIPTOGRAFIA
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

# Bucket para logs
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.project_name}-logs-${var.environment}-${random_string.bucket_suffix.result}"

  tags = {
    Name        = "${var.project_name}-logs-bucket"
    Environment = var.environment
    Purpose     = "Access logs storage"
  }
}

# Sufixo aleatorio para garantir nomes �nicos
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# ======================
# CRIPTOGRAFIA DOS BUCKETS
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

# Criptografia do bucket de logs
resource "aws_s3_bucket_server_side_encryption_configuration" "logs_bucket" {
  bucket = aws_s3_bucket.logs_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# ======================
# CONFIGURA��ES DE SEGURAN�A
# ======================

# Bloquear acesso p�blico no bucket principal
resource "aws_s3_bucket_public_access_block" "main_bucket" {
  bucket = aws_s3_bucket.main_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bloquear acesso p�blico no bucket de logs
resource "aws_s3_bucket_public_access_block" "logs_bucket" {
  bucket = aws_s3_bucket.logs_bucket.id

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
    status = "Enabled"
  }
}

# Versionamento do bucket de logs
resource "aws_s3_bucket_versioning" "logs_bucket" {
  bucket = aws_s3_bucket.logs_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ======================
# LOGGING DE ACESSO
# ======================

# Configurar logging de acesso para o bucket principal
resource "aws_s3_bucket_logging" "main_bucket" {
  bucket = aws_s3_bucket.main_bucket.id

  target_bucket = aws_s3_bucket.logs_bucket.id
  target_prefix = "access-logs/"
}

# ======================
# LIFECYCLE RULES
# ======================

# Regras de ciclo de vida para o bucket principal
resource "aws_s3_bucket_lifecycle_configuration" "main_bucket" {
  bucket = aws_s3_bucket.main_bucket.id

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
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

# Regras de ciclo de vida para logs
resource "aws_s3_bucket_lifecycle_configuration" "logs_bucket" {
  bucket = aws_s3_bucket.logs_bucket.id

  rule {
    id     = "delete_old_logs"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}