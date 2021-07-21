provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  // source = "github.com/tuGithub/tf-test//modules/services/webserver-cluster?ref=v0.0.2"
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-mintu-s3"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
  enable_autoscaling   = false
  enable_new_user_data = true

  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
}



output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}