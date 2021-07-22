provider "aws" {
  region = "us-east-2"

}

module "hello_world_app" {
  source = "../../../modules/services/hello-world-app"

  server_text            = "hello-world-app"
  environment            = "stage"
  db_remote_state_bucket = "terraform-up-and-running-state-mintu-s3"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false

    custom_tags = {
    Owner      = "team-hello-world"
    DeployedBy = "terraform"
  }
}

output "alb_dns_name" {
  value       = module.hello_world_app.alb_dns_name
  description = "The domain name of the load balancer"
}
