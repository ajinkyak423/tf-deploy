resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow SSH and App traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH for GitHub Actions/Admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks =["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =["0.0.0.0/0"]
  }

  tags = { Name = "app-sg" }
}

resource "aws_kms_key" "ebs_key" {
  description             = "KMS Key for EBS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = { Name = "app-ebs-key" }
}

resource "aws_kms_alias" "ebs_alias" {
  name          = "alias/app-ebs-key"
  target_key_id = aws_kms_key.ebs_key.key_id
}