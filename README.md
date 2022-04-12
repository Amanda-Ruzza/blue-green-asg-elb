# blue-green-asg-elb
AWS Auto Scaling Group and Elastic Load Balancer deployed with Terraform.

Used Application Load Balancers to deploy instances in 2 different private subnets in separate Availability Zones.
"Blue ASG" + "Green ASG".

1 Application Load Balancer connects to "Private Subnet a" + "Private Subnet b"

Created an HTML template data-user file as a separate Web Page for the "Blue" and the "Green" ASG instances.


