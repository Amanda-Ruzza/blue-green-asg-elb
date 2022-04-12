data "template_file" "blue_template" {
  template = file("${path.module}/user-data.sh.tpl")
  vars = {
    version = "Blue Version"
    color   = "lightblue"
  }
}

resource "aws_launch_template" "blue_template" {
  name_prefix            = "blue_template"
  image_id               = data.aws_ami.aws_basic_linux.id
  instance_type          = var.ec2_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  user_data              = base64encode(data.template_file.blue_template.rendered)

}

resource "aws_autoscaling_group" "blue" {
  #availability_zones = ["us-east-1a"]
  name                = "blue_group"
  desired_capacity    = 1 # This defines 'how big is the ASG'
  max_size            = 3
  min_size            = 0 #If you know that you're not building anything ATM, having 0 on the min size kills everything
  health_check_type   = "ELB"
  force_delete        = true
  vpc_zone_identifier = [data.aws_subnet.private_a.id] #This determines in which subnet I'm launching my ASG

  launch_template {
    id      = aws_launch_template.blue_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Blue-Server"
    propagate_at_launch = true
  }

  timeouts {
    delete = "5m"
  }
}