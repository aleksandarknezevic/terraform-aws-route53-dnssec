data "aws_route53_zone" "route53_zone" {
  name         = var.route53_zone_name
  private_zone = false
}

data "aws_route53_zone" "route53_parent_zone" {
  count = var.route53_create_ds_record ? 1 : 0
  name  = var.route53_parent_zone_name
}