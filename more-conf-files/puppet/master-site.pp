#
# PUPPET CONFIGURATION FOR A HADOOP 1.2.1 SLAVE NODE
#

#
# VARIABLES
#

# User
$INSTALL_USER = "MaC"

# Hadoop install dir
$HADOOP_INSTALL = "/var/hadoop"

# Update repositories

# Install git and Java
package {'git': 			ensure => installed }
package {'java-1.7.0-openjdk': 	ensure => installed }

# Clone hadoop repository
exec {'clone-repository': 
	command => '/usr/bin/git clone https://github.com/sayden/hadoop-1.2.1.git $HADOOP_INSTALL',
	require => Package['git'],
	onlyif => '/usr/bin/test -e $HADOOP_INSTALL'
}

# Set the file permissions to Hadoop directory
file { "$HADOOP_INSTALL":
	recurse => true,
	owner => $INSTALL_USER,
	group => $INSTALL_USER,
}

# Open Firewall ports
# TODO

# Create hdfs dir
exec {'create-hdfs-dir':
	command => '/bin/mkdir /var/hadoop/hdfs',
	onlyif => "/usr/bin/test -e $HADOOP_INSTALL/hdfs"
}

# Export env vars
exec {'env-vars':
	command => "/bin/bash /home/${INSTALL_USER}/set-env-vars.sh"
}