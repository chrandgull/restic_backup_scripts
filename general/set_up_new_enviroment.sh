#!/bin/bash

#Determine if have the correct programs installed

if [! command -v gpg ]; then	
	missingCommand='True'
    echo "gpg could not be found"
fi
exit 0

if ! command -v pass & > /dev/null
then
	missingCommand='True'
    echo "pass could not be found"
fi

if [ missingCommand = "True"]; then
	echo 'Required programs were missing. Correct situation and retry'
fi


#Determine the name of the folder you want to back up. 
echo "What folder do you want to back up?"
read folderToBackUp


if [ -d "$folderToBackUp" ];
then
    echo "Directory $folderToBackUp exists. Good." 
else
    echo "Error: Directory $folderToBackUp does not exist. Error."
	exit 12
fi


while :
 do
    echo "What nickName to you want to give this repository? (Required)"
	read repoNickName
 	if [ -n "$repoNickName" ]; then
		break
	fi
 done

while :
 do
    echo "What is the hostname of the computer you are backing up"
	read repoHostName
 	if [ -n "$repoHostName" ]; then
		break
	fi
 done
 

 
echo "Repo nickname is: " $repoNickName
echo "Repo hostname is: " $repoHostName

echo "Now inserting variables into pass"

echo "When prompted, enter the name of your B2 When prompted enter b2: followed by the name of the B2 bucket you created"
echo "Example: b2:chrandgull-laptop-79539"

pass insert "$(repoHostName)"/$(repoNickName)/RESTIC_REPOSITORY

echo "When prompted paste in the keyID of the application key that you created."

pass insert "$(repoHostName)"/$(repoNickName)/B2_ACCOUNT_ID

echo "When prompted paste in the secret value of the application key you created."
pass insert "$(repoHostName)"/$(repoNickName)/B2_ACCOUNT_KEY

echo "Generating an encryption password. Make sure to save it somewhere safe!"

pass generate "$(repoHostName)"/$(repoNickName)"/RESTIC_PASSWORD

echo "******************************************************"
echo "                   Save this password!                "
echo "******************************************************"
pass show --clip "$(hostname)"/RESTIC_PASSWORD

echo "Checking to see if ~/.restic exists"

if [ -d "~./restic" ] 
then
    echo "Directory ~./restic exists." 
else
    echo "Error: Directory ~./restic does not exist. Creating it"
	mkdir -p ~./restic/$repoHostName/$repoNickName
	
	if [ $? -ne 0 ] ; then
    	echo "Fatal error. Could not create ~/.restic directory "
		exit 12
	fi
fi


