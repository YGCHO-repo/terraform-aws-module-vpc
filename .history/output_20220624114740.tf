output "account_id" {
    description = "AWS Account ID"
    value = var.account_id
}

output "vpc_id" {
    description = "AWS VPC ID"
    value = aws_vpc.this.id
}

output "vpc_cidr_block" {
    description = "CIDR block for VPC"
    value = aws_subnet.this.cidr_block
}

output "igw_id" {
    description = "Internet gateway ID"
    value = aws_internet_gateway.this.id
}

output "natgw_id" {
    description = "Nat gateway ID"
    value = aws_nat_gateway.this.id
}

output "subnet_ids" {
    description = "Subnet ID List"
    value = [aws_subnet.this]
}