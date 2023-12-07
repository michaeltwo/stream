#!/bin/bash
#Rocky9
yum install wget
yum install git
cd ~
wget https://nginx.org/download/nginx-1.25.3.tar.gz
tar -zxvf nginx-1.25.3.tar.gz
cd nginx-1.25.3
git clone  https://github.com/arut/nginx-rtmp-module.git
#install dependencies, if cannot find then yum search XXX.http://ffmpeg.org/
sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm -y
dnf install ffmpeg 
yum install gcc
yum install libxml2-devel.x86_64
yum install pcre-devel
yum install zlib
yum install openssl-devel
yum install gd-devel
#configure and install
./configure --prefix=/usr/local/nginx \
--with-debug \
--with-compat \
--with-threads \
--with-pcre \
--with-pcre-jit \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_slice_module \
--with-http_stub_status_module \
--with-http_realip_module \
--with-http_auth_request_module \
--with-http_addition_module \
--with-http_gzip_static_module \
--with-http_gunzip_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_image_filter_module \
--with-http_xslt_module \
--with-stream \
--add-module=./nginx-rtmp-module
#install software to /usr/local/nginx
make && make install
#copy nginx.conf file to /usr/local/nginx/conf
git clone https://
cp nginx.conf /usr/local/nginx/conf
#/usr/local/nginx/sbin/nginx -t
/usr/local/nginx/sbin/nginx
#/usr/local/nginx/sbin/nginx -s stop
#streaming mp4 file
 ffmpeg -re -i example-vid.mp4 -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -f flv rtmp://localhost/show/stream
#streaming webcamrea /dev/video0
#ffmpeg -re -f video4linux2 -i /dev/video0 -vcodec libx264 -vprofile baseline -acodec aac -strict -2 -f flv rtmp://localhost/show/stream
 #test website
 #http://localhost:8080/hls/stream.m3u8
 #rtmp://localhost/show/stream
 
