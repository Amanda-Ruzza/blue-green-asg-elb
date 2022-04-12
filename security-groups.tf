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
    cidr_blocks = ["0.0.0.0/0"] # Access to the web server from internet
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
