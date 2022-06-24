# Subnet 전체 데이터 
locals {
  all_subnets = flatten([
    for key, value in var.subnets : [
      for item in value.cidr : {
        name = key
        cidr = item
      }
    ]
  ])
}


# Public subnet만 추출하기
locals {
  public_subnets = flatten([
    for key, value in var.subnets : [
      for item in value.cidr : {
        name = key
        cidr = item
      }
    ] if value.ipv4_type == "public"
  ])
}


# Private subnet만 추출하기
locals {
    private_subnets = flatten([
        for key, value in var.subnets : [
            for item in value.cidr : {
                name = key
                cidr = item
            }
        ]
    ])
}