# aws profile (e.g. from aws configure, usually "default")
aws_profile = "gov-rd-staging"
aws_region  = "us-gov-west-1"

aws_default_tags = {
  Client      = "rd"
  Environment = "fake-digest"
  Product     = "fake-digest"
  TF-Project  = "local-nifi-cgmckeever"
}

# existing aws iam user granted access to the kms key (for browsing KMS encrypted services like S3 or SNS).
kms_manager = "cgmckeever"

# the subnet(s) permitted to browse nifi (port 2170 or web_port) via the AWS NLB
mgmt_cidrs = ["0.0.0.0/0"]

# the subnet(s) permitted to send traffic to service ports
client_cidrs = []

# management port for HTTPS (and inter-cluster communication) via mgmt NLB
web_port = 2170

# service ports for traffic inbound via service NLB
tcp_service_ports    = [2200, 2201]
udp_service_ports    = []
tcpudp_service_ports = []

# inter-cluster communication occurs on ports web_port and 2171 through 2176

# public ssh key
instance_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDE3r5eezM7ZbJBqsNPCuNSZ5n7NpDBVWUORrfK4ClCEbMF35IFBx7KgKVFbS74HZ5HyWaCHyy8cYRApwOfJWrt3f9vDgInCxhB6FOPT8Aj3aqbcuOPA75w/MttNhD0s1cpIWMJOlxUdhpy+/koeuwloTqTgK/uwUx1GZLFiYypRkzvnxIjMbq1pQo7gCwUJZoR4Oj79NgJQZiCmHomKc6fU5u0Idh6W/mTf8CGqMS6F4nLR/cOhLtHVuSz/8skWuXt3cY4QTw8kwE5nMBqKHQLrk6gVuPY/7T1m7ygC2HF+QWeJYjARZPM8Pi/75NzsafeXvfTb9/AATfDxdL9gN9n"

# size according to workloads, must be x86 based with at least 2GB of RAM (which is barely enough).
instance_type = "r5.2xlarge"

# the root block size of the instances (in GiB)
instance_vol_size = 50

# enable first/second/third zookeeper+nifi nodes (1 for yes, 0 for no)
enable_zk1 = 1
enable_zk2 = 1
enable_zk3 = 0

# the initial size (min) and max count of non-zookeeper nifi nodes.
# scale is based on CPU load (see nifi-scaling-nodes.tf)
minimum_node_count = 1
maximum_node_count = 1

# the name prefix for various resources (e.g. "nifi" for "nifi-encrypted-ami", "nifi-zk1-", ...)
name_prefix = "nifi"

# the vendor supplying the AMI and the AMI name - default is official Ubuntu 20.04
vendor_ami_account_number = "513442679011"
vendor_ami_name_string    = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"

# days to retain logs in cloudwatch
log_retention_days = 30

# health check frequency - if an instance fails a health check it is terminated and replaced
health_check_enable = true
health_check_unit   = "minutes"
health_check_count  = 10

# nifi/nifi-toolkit and zookeeper versions downloaded from urls below
nifi_version = "1.13.2"
zk_version   = "3.7.0"

# urls for a lambda function to fetch zookeeper, nifi, and nifi toolkit and put to s3
zk_url      = "https://apache.osuosl.org/zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0-bin.tar.gz"
nifi_url    = "https://apache.osuosl.org/nifi/1.13.2/nifi-1.13.2-bin.tar.gz"
toolkit_url = "https://apache.osuosl.org/nifi/1.13.2/nifi-toolkit-1.13.2-bin.tar.gz"

# vpc specific vars, modify these values if there would be overlap with existing resources.
vpc_cidr     = "10.10.10.0/24"
pubnet1_cidr = "10.10.10.0/28"
pubnet2_cidr = "10.10.10.16/28"
pubnet3_cidr = "10.10.10.32/28"
prinet1_cidr = "10.10.10.64/26"
prinet2_cidr = "10.10.10.128/26"
prinet3_cidr = "10.10.10.192/26"
