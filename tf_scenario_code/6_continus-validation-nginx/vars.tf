variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable ec2_key {
  type = string
  default = "DPT-Vault-kp-common"
}
variable ec2_type {
  type = string
  default = "m7g.medium"
}

variable ami_id {
  type = list(string)
  default = ["ami-0c1f7b7eb05c17ca5"]
  # default = ["ami-0c031a79ffb01a803"]
  description = "Amazon Linux 2023 AMI ARM64 지원 AMI"
}