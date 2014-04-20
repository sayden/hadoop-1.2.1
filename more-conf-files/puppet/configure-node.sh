#! /bin/bash

#Check if there is arguemnts
if [ $# -ne 0 ]; then
	#Send the apt-get update command to update repositories
	ssh -i $1 ubuntu@$2 'sudo apt-get update -y'
	echo 'apt-get update done'

	#Install puppet
	ssh -i $1 ubuntu@$2 'sudo apt-get install -y puppet'
	echo 'Puppet installed'

	#Send the puppet provisioning file
	scp -i $1 $3 ubuntu@$2:/home/ubuntu
	echo 'Puppet file sent'

	#Execute the provisioning on the target machine
	ssh -i $1 ubuntu@$2 'sudo puppet apply $2'
	echo 'Machine provisioned'

	#Final message
	echo 'All operations completed'
else
	echo 'Not enough arguments'
	echo 'Usage:'
	echo 'configure-node [identity-file.pem] [target-ip] [puppet-file.pp]'
fi
