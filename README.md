# Unzip for File Actions in Nextcloud

    A small script for file actions in Nextcloud, this script as
    mentioned in the name unzips selected files into the current 
    directory under file name without the extension, on this branch
    an update has been made to be able to unzip in the current directory.

# Features 
- Extract all supported compressed extensions.
- Choose which directory to extract the files to.
- Support for different languages of file names and directories
- Easily to use and install on Nextcloud and less maintanance than the original Extract extension.

# Requirements:

    1. 7z and unrar, install them on the docker container not on the host.
    2. Nextcloud Docker Container.
    3. File Actions extension: https://github.com/Raudius/files_scripts/tree/master.

The script has only been tested on Nextcloud docker image

# Install 7z:
    docker exec -it -u root nextcloud-container /bin/bash
    apt update -y
    apt install p7zip-full -y

# Install unrar:

    apt install unrar

# Using File Actions:

    After installing 7z go to your Nextcloud, Apps -> Files -> File Actions -> Install File Actions.

# Installing the script:

    Go to Administration and navigate to File Actions, Add New Actions and Paste the script Enable and show in context menu.

# To use new feature of the branch:
    Go to File Actions, your file action script, and create a Checkbox with the variable "is_dirpath".

*This Branch is specifically for the new feature which uses unrar to extract rar files and it seems more consistent also includes the option to choose whether to extract in the same directory or in a directory under the same name.*


Enjoy!

