data "terraform_remote_state" "networking" {
  backend = "remote"

  config = {
    organization = "AWS-FCJ-Workshop"
    workspaces = {
      name = "dev-networking"
    }
  }
}