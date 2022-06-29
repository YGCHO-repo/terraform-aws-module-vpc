resource "aws_nat_gateway" "this" {
  for_each = { for i in local.public_subnets : i.cidr => i if i.name == "main" }

  allocation_id = aws_eip.nat_eip[index(var.subnets["main"].cidr, each.key)].id
  subnet_id     = aws_subnet.this[each.key].id

  depends_on = [
    aws_internet_gateway.this
  ]

  tags = merge(var.tags,
    tomap({
      Name = format(
        "%s-%s-%s-%s-natgw",
        var.prefix,
        var.vpc_name,
        var.azs[index(var.subnets[each.value.name].cidr, each.key)],
        each.value.name
      )
    })
  )
}