variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "cidr_blocks" {
  type = string
  default = "0.0.0.0/0"
}

variable ec2_key {
  type = string
  default = "DPT-Vault-kp-common"
}
variable ec2_type {
  type = string
  default = "t3.micro"
}