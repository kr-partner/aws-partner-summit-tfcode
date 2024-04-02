resource "aws_security_group" "sentinel-test-sg" {
  name   = "sentinel-test-sg"
  description = "Security group for testing terraform sentinel"

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    
    ## 보안 취약점: 인터넷에 대한 액세스를 제어하지 않음
    # cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = ["192.168.0.0/16"]
    cidr_blocks = [var.cidr_blocks]
    description = "Allow all inbound traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    
    # cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = [var.cidr_blocks]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "sentinel-test-sg"
  }
}
