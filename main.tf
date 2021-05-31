resource "aws_kms_key" "kms_key" {
  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = var.kms_deletion_days
  key_usage                = "SIGN_VERIFY"
  is_enabled               = var.kms_is_enabled
  description              = var.kms_description
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "kms:DescribeKey",
          "kms:GetPublicKey",
          "kms:Sign",
        ],
        Effect = "Allow"
        Principal = {
          Service = "api-service.dnssec.route53.aws.internal"
        }
        Sid = "Route 53 DNSSEC Permissions"
      },
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Resource = "*"
        Sid      = "IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
  tags = merge(
    var.default_tags,
    {
      "Name" = format("%s-kmk", var.route53_zone_name)
    }
  )
}

resource "aws_route53_key_signing_key" "zone_signing_key" {
  name                       = format("%s-ksk", replace(var.route53_zone_name, ".", "-"))
  hosted_zone_id             = data.aws_route53_zone.route53_zone.id
  key_management_service_arn = aws_kms_key.kms_key.arn
}

resource "aws_route53_hosted_zone_dnssec" "hosted_zone_dnssec" {
  hosted_zone_id = aws_route53_key_signing_key.zone_signing_key.hosted_zone_id
}

resource "aws_route53_record" "ds_in_parent_zone" {
  count   = var.route53_create_ds_record ? 1 : 0
  name    = var.route53_zone_name
  type    = "DS"
  zone_id = data.aws_route53_zone.route53_parent_zone[0].zone_id
  ttl     = var.route53_record_ttl
  records = [aws_route53_key_signing_key.zone_signing_key.ds_record]
}