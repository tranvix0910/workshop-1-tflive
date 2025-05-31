data "terraform_remote_state" "iam" {
  backend = "remote"
  config = {
    organization = "AWS-FCJ-Workshop"
    workspaces = {
      name = "dev-iam"
    }
  }
}

data "terraform_remote_state" "load_balancer" {
  backend = "remote"
  config = {
    organization = "AWS-FCJ-Workshop"
    workspaces = {
      name = "dev-load_balancer"
    }
  }
}

data "terraform_remote_state" "database" {
  backend = "remote"
  config = {
    organization = "AWS-FCJ-Workshop"
    workspaces = {
      name = "dev-database"
    }
  }
}

data "terraform_remote_state" "networking" {
  backend = "remote"
  config = {
    organization = "AWS-FCJ-Workshop"
    workspaces = {
      name = "dev-networking"
    }
  }
}

data "terraform_remote_state" "security" {
  backend = "remote"
  config = {
    organization = "AWS-FCJ-Workshop"
    workspaces = {
      name = "dev-security"
    }
  }
}



