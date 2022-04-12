resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allows access to this server only from the public instance private IP "
  vpc_id      = data.aws_vpc.main_vpc.id #attach the private security group from the instances


  # INBOUND CONNECTIONS

  ingress {
    description = "Allows SSH into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.loadbalancer_sg.id]
  }

  #OUTBOUND CONNECTIONS

  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }

#Creating a specific Security Group for the Load Balancer
resource "aws_security_group" "loadbalancer_sg" {
  name        = "lb_sg"
  description = "Allows access to this Load Balancer "
  vpc_id      = data.aws_vpc.main_vpc.id #LB will be inside my VPC


  # INBOUND CONNECTIONS

  ingress {
    description = "Allows SSH into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.loadbalancer_sg] #Only 'devices' attached with this SG will be aloowed to connect to PORT 80
  }

  #OUTBOUND CONNECTIONS

  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }



}


}
