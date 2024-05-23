A small script for file actions in Nextcloud, this script as mentioned in the name unzips selected files into the current directory under file name without the extension 
Requirements:
1. 7z install it on the docker container not on the host
2. Nextcloud Docker Container 
3. File Actions extension: https://github.com/Raudius/files_scripts/tree/master

The script has only been tested on Nextcloud docker image

Install 7z:
In the terminal as root
docker exec -it -u root nextcloud-container /bin/bash
apt update -y
sudo apt install p7zip-full -y

Using File Actions:
After installing 7z go to your Nextcloud, Apps -> Files -> File Actions -> Install File Actions

Installing the script:
Go to Administration and navigate to File Actions, Add New Actions and Paste the script Enable and show in context menu

Done, Enjoy!
