resource "aws_vpc" "this" {  
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = merge(
        var.tags, 
        tomap({"Name" = "${var.prefix}-${var.vpc_name}"})
    )
}