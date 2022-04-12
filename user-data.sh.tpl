#!/bin/bash

sudo yum update
sudo amazon-linux-extras install nginx1
sudo service nginx start
sudo systemctl enable nginx.service

#Web Page
cat <<EOF > /usr/share/nginx/html/index.html
<html>
<title> ${version} </title>
<body style="background-color:${color};"
<h1> This is the ${version} </h1>
<h2> How do you like this version?</h2>
</body>
</html>
EOF