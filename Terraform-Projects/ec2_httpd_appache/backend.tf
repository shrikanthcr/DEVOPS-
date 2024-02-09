terraform {
    backend "s3" {
        bucket = "project-register-01"
        key    = "JENKINS/terraform.tfstate"
        region = "us-east-2"
    }
}
