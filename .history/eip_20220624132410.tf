resource "aws_eip" "nat_eip" {
    # count = length(var.azs)
    # count = "${var.enable_internet_gateway == "true" && var.enable_nat_gateway == "true" ? length(var.azs) : 0 }"
    count = "${ var.enable_internet_gateway == "true" && var.enable_nat_gateway == "true" ? length(var.azs) : 0 }"

    vpc = true

    tags = merge(var.tags, tomap({"Name" = format("%s-nat-%s-eip, ${var.prefix}, ${substr(var.azs, -2. 2)}")}))
}