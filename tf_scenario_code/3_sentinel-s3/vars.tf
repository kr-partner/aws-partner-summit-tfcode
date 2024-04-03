variable "acl_enabled" {
  type    = bool
  default = false # ACL을 활성화하려면 true로 설정하세요
}

variable "region" {
  type = string
  default = "ap-northeast-2"
}