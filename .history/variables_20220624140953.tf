variable "region" {
    description = "AWS Region name"
    type = string
    default = ""
}

variable "account_id" {
    description = "List of Allowed AWS account IDs"
    type = list(string)
    default = [""]
}

variable "prefix" {
    description = "Prefix name"
    # ex< prd, stg, dev, test
    type = string
}

variable "vpc_name" {
    description = "Create AWS VPC name"
    type = string
}

variable "vpc_cidr" {
    description = "AWS VPC Default CIDR"
    # ex> 10.5.0.0/16
    type = string
}

variable "azs" {
    description = "AWS Region AZ List"
    type = list
}

variable "enable_internet_gateway" {
    description = "Internet gateway whether or not use"
    type = string
    default = "fales"
}

variable "enable_nat_gateway" {
    description = "Nat gateway whether or not use"
    type = string
    default = "fales"
}

variable "tags" {
    description = "tag map"
    type = map(string)
}

variable "subnets" {
    description = "Subnet map"
    type = map(any)
}