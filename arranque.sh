#!/bin/bash
apt update && apt install -y nginx
echo "<h1><identificacion></h1><p>Servida desde Terraform por $(hostname)</p>" > /var/www/html/index.html