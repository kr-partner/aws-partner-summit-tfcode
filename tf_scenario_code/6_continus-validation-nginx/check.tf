
check "response" {
  data "http" "nginx" {
   url      = "http://${aws_instance.ec2.public_dns}"
#  url = "https://www.terraform.io"

  depends_on = [time_sleep.wait_15_seconds]
}

  assert {
    condition     = data.http.nginx.status_code == 200
    error_message = "returned an unhealthy status code ${data.http.nginx.status_code}"
  }
  assert {
    condition     = aws_instance.ec2.instance_state == "running"
    error_message = "The EC2 Instance is not running"
  }
}

