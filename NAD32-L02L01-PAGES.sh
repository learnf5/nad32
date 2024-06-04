# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update Student Workstation host for the specific lab
# only if need a simpler /etc/hosts file do the following 2 steps
# curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab01/hosts
# sudo cp /tmp/hosts                                  /etc/hosts

# update nginx host for the specific lab

sudo ssh nginx mkdir --parents /home/ubuntu/public_html/application1
sudo ssh nginx mkdir --parents /home/ubuntu/public_html/application2
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/ubuntu/public_html/application1/app1.html
sudo scp /tmp/app1.html                                    nginx:/home/ubuntu/public_html/application1/
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/ubuntu/public_html/application2/app2.html
sudo scp /tmp/app1.html                                    nginx:/home/ubuntu/public_html/application2/

sudo ssh nginx mkdir --parents /home/ubuntu/public_html/shop/product/
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/common/ubuntu/public_html/shop/product/product{1,2,3}.html
sudo scp /tmp/product*.html                                nginx:/home/ubuntu/public_html/shop/product/
