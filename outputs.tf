output "key_arn" {
  value = aws_kms_key.kms_key.arn
}

output "key_id" {
  value = aws_kms_key.kms_key.id
}

output "dnskey_record" {
  value = aws_route53_key_signing_key.zone_signing_key.dnskey_record
}

output "ds_record" {
  value = aws_route53_key_signing_key.zone_signing_key.ds_record
}

output "key_tag" {
  value = aws_route53_key_signing_key.zone_signing_key.key_tag
}

output "key_public_key" {
  value = aws_route53_key_signing_key.zone_signing_key.public_key
}
