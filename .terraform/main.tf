
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "josercf-state-bucket-tf"  # O nome deve ser globalmente único
  acl    = "private"  # Define o bucket como privado

  versioning {
    enabled = true  # Opcional: habilita versionamento
  }
}


resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = [
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
        Principal = "*"  # Ajuste conforme a necessidade para especificar usuários ou roles
      }
    ]
  })
}

