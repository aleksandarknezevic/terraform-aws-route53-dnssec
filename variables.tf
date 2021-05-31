variable "default_tags" {
  type = map(string)
  default = {
    Administrator = ""
    Environment   = ""
  }
  description = "A map of default tag blocks."
}

variable "kms_deletion_days" {
  description = "Days for deletion KMS key"
  type        = number
  default     = 7
}

variable "kms_description" {
  description = "Description for created KMS key for signing"
  type        = string
  default     = "KMK key for DNSSEC"
}

variable "kms_is_enabled" {
  description = "Whether if kms key enabled"
  type        = bool
  default     = true
}

variable "route53_zone_name" {
  description = "Name of Route53 zone"
  type        = string
}

variable "route53_record_ttl" {
  description = "TTL for route53 ds record in parent zone"
  type        = number
  default     = 3600
}

variable "route53_create_ds_record" {
  description = "Whether if you want to add ds record in parent zone. If you want you should set variable route53_parent_zone_name"
  type        = bool
  default     = false
}

variable "route53_parent_zone_name" {
  description = "Name for the parent zone for inserting DS record"
  type        = string
  default     = ""
}