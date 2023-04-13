#!/usr/bin/env bash
# Bash script that sets up your web servers for the deployment of web_static

sudo apt-get -y update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'
echo "Hello World!" | sudo tee /var/www/html/index.html
echo "Ceci n'est pas une page" | sudo tee /var/www/html/404.html
echo "server {
	listen 80 default_server;
	location /hbnb_static {
		alias /data/web_static/current;
		index index.html;
		try_files \$uri \$uri/ =404;
	}
	error_page 404 /404.html;
	location = /404.html{
		internal;
	}
	location /redirect_me {
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
	}
}" > default_file
sudo mv -f default_file /etc/nginx/sites-enabled/default
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/
echo "<html>
  <head>
  </head>
  <body>
    WELCOME TO ALX SCHOOL
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
sudo service nginx restart
