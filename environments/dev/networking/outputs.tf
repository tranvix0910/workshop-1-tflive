output "vpc_id" {
    value = module.networking.vpc_id
}

output "vpc_arn" {
    value = module.networking.vpc_arn
}

output "public_subnet_ids" {
    value = module.networking.public_subnets
}

output "private_subnet_ids" {
    value = module.networking.private_subnets
}
