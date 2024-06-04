# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# get lab-info.md for student guide bravais id
curl --silent https://raw.githubusercontent.com/learnf5/nad32/main/lab-info.md --output /tmp/lab-info.md
brav_id=$(awk -F '|' "/$LAB_ID/"' {print $2}' /tmp/lab-info.md)

# install student guide
cat <<'EOF' >/home/student/Desktop/Lab_Guide.desktop
[Desktop Entry]
Version=1.0
Name=Lab Guide
Icon=document
Terminal=false
Type=Application
Categories=Application;
EOF
echo Exec=google-chrome --app=https://f5.bravais.com/s/$brav_id >>/home/student/Desktop/Lab_Guide.desktop
gio set /home/student/Desktop/Lab_Guide.desktop metadata::trusted true
chmod +x /home/student/Desktop/Lab_Guide.desktop

# common files for all labs
sudo ssh nginx mkdir --parents /home/ubuntu/public_html/application1
sudo ssh nginx mkdir --parents /home/ubuntu/public_html/application2
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/ubuntu/public_html/index.html
sudo scp /tmp/index.html                                   nginx:/home/ubuntu/public_html/index.html
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/ubuntu/public_html/application1/app1.html
sudo scp /tmp/app1.html                                    nginx:/home/ubuntu/public_html/application1/
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/ubuntu/public_html/application2/app2.html
sudo scp /tmp/app2.html                                    nginx:/home/ubuntu/public_html/application2/

sudo ssh nginx mkdir --parents /home/ubuntu/public_html/shop/product
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/ubuntu/public_html/shop/product/product{1,2,3}.html
sudo scp /tmp/product*.html                                nginx:/home/ubuntu/public_html/shop/product/

sudo ssh nginx mkdir --parents /data/images
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/data/images/logo.png
sudo scp /tmp/logo.png                                    nginx:/data/images/

sudo ssh nginx mkdir --parents /data/server2/sampleapp
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/data/server2/sampleapp/index.html
sudo scp /tmp/index.html                                  nginx:/data/server2/sampleapp/

# run this lab's specific tasks saved on GitHub
curl --silent --output /tmp/$LAB_ID.sh https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/$LAB_ID.sh
bash -x /tmp/$LAB_ID.sh

# restart NGINX
sudo ssh nginx systemctl stop nginx
sudo ssh nginx systemctl start nginx
