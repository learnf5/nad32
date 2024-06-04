# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update Student Workstation host for the specific lab
# only if need a simpler /etc/hosts file do the following 2 steps
# curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab01/hosts
# sudo cp /tmp/hosts                                  /etc/hosts

# update nginx host for the specific lab

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab03/default.bak
sudo scp /tmp/default.bak                              nginx:/etc/nginx/conf.d/

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nad32/main/lab03/mywebserver.bak
sudo scp /tmp/mywebserver.bak                              nginx:/etc/nginx/conf.d/
