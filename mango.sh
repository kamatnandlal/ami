

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd


echo "<h1>Welcome to CentOS AMI</h1>" | sudo tee /var/www/html/index.html
