# Sample Terraform configuration with intentional security issues
# Use this file to test the Cloud Security Scanner

# Issue 1: Public S3 bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-bucket"
  acl    = "public-read"
}

# Issue 2: Security group with unrestricted SSH access
resource "aws_security_group" "allow_ssh_from_anywhere" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Issue 3: Overly permissive IAM policy
resource "aws_iam_policy" "admin_policy" {
  name        = "admin_policy"
  description = "Admin policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# Issue 4: Hardcoded credentials
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
              export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
              EOF
}

# Issue 5: Unencrypted EBS volume
resource "aws_ebs_volume" "unencrypted_volume" {
  availability_zone = "us-west-2a"
  size              = 40
  encrypted         = false
}

# Issue 6: Publicly accessible RDS database
resource "aws_db_instance" "public_database" {
  identifier           = "mydb"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "password123"
  publicly_accessible  = true
  skip_final_snapshot  = true
}

# Issue 7: S3 bucket without encryption
resource "aws_s3_bucket" "no_encryption" {
  bucket = "my-unencrypted-bucket"
}

# Secure example for comparison
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "secure_bucket_encryption" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
