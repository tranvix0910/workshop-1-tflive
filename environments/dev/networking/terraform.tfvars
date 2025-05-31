region = "ap-southeast-1"
vpc_name = "wine-app-vpc"
vpc_cidr = "10.0.0.0/16"
vpc_azs = ["ap-southeast-1a", "ap-southeast-1b"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_public_subnet_names = ["wine-app-public-subnet-1", "wine-app-public-subnet-2"]
vpc_private_subnet_names = ["wine-app-private-subnet-1", "wine-app-private-subnet-2"]
