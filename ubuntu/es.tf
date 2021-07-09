module "elasticsearch" {
  source = "git@gitlab.rebellion.dev:rebelliondefense/terraform/tf-mod-elasticsearch.git?ref=v11"

  dedicated_master   = true
  es_ebs_volume_size = 512
  es_instance_count  = 4
  es_instance_type   = "r5.2xlarge.elasticsearch"
  es_subnet_ids = [
    aws_subnet.tf-nifi-prinet1.id,
    aws_subnet.tf-nifi-prinet2.id,
    aws_subnet.tf-nifi-prinet3.id
  ]
  es_version = "7.9"

  app_security_group_ids = {
    nifi_ec2 = aws_security_group.tf-nifi-prisg.id
  }

  service_parameter_store_info = {}

  account_info      = local.account_info
  rd_resource_ident = local.rd_resource_ident
  vpc_info          = local.vpc_info
}

data "aws_partition" "current" {}

locals {
  account_info = {
    id        = "fake"
    partition = data.aws_partition.current.partition
  }

  rd_resource_ident = {
    app_name          = "fake-digest-es",
    client_name       = "rd",
    product_name      = "fake-digest",
    terraform_project = "local-nifi-cgmckeever"
  }

  vpc_info = {
    vpc_cidr_block = aws_vpc.tf-nifi-vpc.cidr_block
    vpc_env_name   = "fake-digest"
    vpc_id         = aws_vpc.tf-nifi-vpc.id
    vpc_name       = "fake-digest"
    vpc_region     = "us-gov-west-1"
  }
}
