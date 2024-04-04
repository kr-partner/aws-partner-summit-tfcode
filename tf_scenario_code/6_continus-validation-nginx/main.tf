data "aws_ami" "al2023_arm" {
  most_recent = true

  owners = ["amazon"]
  
  filter {
    name = "image-id"
    values = var.ami_id
    # ami-0c031a79ffb01a803는 x86_64 이미지
    # ami-0c1f7b7eb05c17ca5는 arm64 이미지
  }
}

resource "aws_instance" "ec2" {
  ami           = var.ami_id[0] # Graviton3 기본 이미지 사용
  instance_type = var.ec2_type
  key_name      = var.ec2_key
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ngnix-sg.id]
  lifecycle {
    # AMI 이미지는 ARM 아키텍처만 사용해야 함
    precondition {
      condition     = data.aws_ami.al2023_arm.architecture == "arm64"
      error_message = "AMI 이미지는 반드시 ARM 64 기반의 이미지어야 합니다. 예) ami-0c1f7b7eb05c17ca5"
    }
  }
  tags = {
    Name = "6_continus-validation"
  }
  user_data = <<-EOF
    #!/bin/bash
    yum install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    EOF
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_instance.ec2]
  create_duration = "30s"
}

output "ec2_public_dns" {
  value = aws_instance.ec2.public_dns
}


resource "aws_security_group" "ngnix-sg" {
  name   = "ngnix-sg"
  description = "Security group for testing terraform enterprise drift detection"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound traffic"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}
