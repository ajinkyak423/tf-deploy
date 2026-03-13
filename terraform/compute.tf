data "aws_ami" "ubuntu" {
  most_recent = true
  owners      =["099720109477"]

  filter {
    name   = "name"
    values =["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids =[aws_security_group.app_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ubuntu
  EOF

  tags = { Name = "ubuntu-app-server" }
}

resource "aws_ebs_volume" "app_data" {
  availability_zone = aws_instance.app_server.availability_zone
  size              = 10
  encrypted         = true
  kms_key_id        = aws_kms_key.ebs_key.arn

  tags = { Name = "app-data-vol" }
}

resource "aws_volume_attachment" "data_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.app_data.id
  instance_id = aws_instance.app_server.id
}