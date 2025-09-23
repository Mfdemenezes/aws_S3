# 🗄️ AWS S3 Infrastructure with Terraform

Projeto simples para criar bucket S3 criptografado na AWS usando Terraform com state no S3.

## 🚀 Características

- **Bucket S3 único**: Simples e direto
- **Criptografia**: AES256 habilitada
- **Versionamento**: Controle de versões
- **Lifecycle rules**: Transição automática para IA e Glacier
- **Segurança**: Bloqueio de acesso público
- **Backend remoto**: tfstate armazenado no S3

## 📋 Bucket Criado

**Bucket Principal**: `storage-marcelo-dev-{random}`
- Armazenamento de dados criptografado
- Criptografia AES256 por padrão
- Versionamento habilitado
- Lifecycle rules configuradas
- Acesso público bloqueado

## 🛠️ Como usar

### Deploy via GitHub Actions
1. **Automático**: Push para `main` → Deploy automático
2. **Manual**: Actions → Deploy S3 → `apply`

### Deploy local
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Destroy
```bash
# Via GitHub Actions
Actions → Destroy S3 → Digite "DESTROY"

# Local
terraform destroy
```

## 📊 Outputs

Após o deploy, você terá:
- Nome do bucket
- ARN do bucket
- Informações de criptografia
- Resumo completo da infraestrutura

## 🔒 Segurança

- ✅ Criptografia AES256
- ✅ Bloqueio de acesso público
- ✅ Versionamento habilitado
- ✅ State criptografado no S3