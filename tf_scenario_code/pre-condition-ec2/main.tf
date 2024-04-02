data "aws_ami" "al2" {
  most_recent = true

  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["*amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.al2.id
  instance_type = var.ec2_type
  key_name      = var.ec2_key
  associate_public_ip_address = true
  tags = {
    Name = "ec2-precondition-test"
  }
  lifecycle {
    # The AMI ID must refer to an AMI that contains an operating system
    # for the `x86_64` architecture.
    precondition {
      condition     = data.aws_ami.al2.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture."
    }
  } 
}
