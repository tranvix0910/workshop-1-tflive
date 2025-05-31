data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "AWS-FCJ-Workshop"
    workspaces = {
      name = "dev-networking"
    }
  }
}