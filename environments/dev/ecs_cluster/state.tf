 terraform {
    cloud {
        organization = "AWS-FCJ-Workshop"
        workspaces {
            project = "Workshop 1"
            name    = "dev-ecs_cluster" 
        }
    }
}