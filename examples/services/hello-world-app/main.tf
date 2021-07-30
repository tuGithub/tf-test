provider "aws" {
  region = "us-east-2"

}

module "hello_world_app" {
  source = "../../../modules/services/hello-world-app"

  server_text            = "hello-world-app-example"
  environment            = "example"

  # Pass all the outputs from the mysql module straight through!
  mysql_config = module.mysql

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false

    custom_tags = {
    Owner      = "team-hello-world"
    DeployedBy = "terraform"
  }
}

module "mysql" {
  source = "../../../stage/data-storage/mysql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

output "alb_dns_name" {
  value       = module.hello_world_app.alb_dns_name
  description = "The domain name of the load balancer"
}
