# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update nginx host for the specific lab

#Remove default.conf file since this lab requires only default.bak
sudo ssh nginx rm /etc/nginx/conf.d/default.conf

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab03/default.bak
sudo scp /tmp/default.bak                              nginx:/etc/nginx/conf.d/

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab11/mywebserver.bak
sudo scp /tmp/mywebserver.bak                              nginx:/etc/nginx/conf.d/

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab03/return_test.bak
sudo scp /tmp/return_test.bak                              nginx:/etc/nginx/conf.d/

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab06/variable_test.bak
sudo scp /tmp/variable_test.bak                              nginx:/etc/nginx/conf.d/

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab11/sampleapp.bak
sudo scp /tmp/sampleapp.bak                              nginx:/etc/nginx/conf.d/sampleapp.bak

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab11/ssl-params.bak
sudo scp /tmp/ssl-params.bak                              nginx:/etc/nginx/conf.d/
