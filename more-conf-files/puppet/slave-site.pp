#
# PUPPET CONFIGURATION FOR A HADOOP 0.20 SLAVE NODE
#

# Install git
package {'git': ensure => installed }

# Clone hadoop repository
exec {'clone-repository': 
	command => '/usr/bin/git clone https://github.com/sayden/hadoop-1.2.1.git /var/hadoop',
	require => Package['git'],
	unless => '/usr/bin/test -e /var/hadoop'
}

# Set the file permissions to Hadoop directory
file { "/var/hadoop":
	recurse => true,
	owner => "ubuntu",
	group => "ubuntu",
}

# Create hdfs dir
exec {'create-hdfs-dir':
	command => '/bin/mkdir /var/hadoop/hdfs',
	require => Exec['clone-repository'],
	unless => "/usr/bin/test -e /var/hadoop/hdfs"
}

# Install Java
package{'openjdk-6-jdk': ensure => installed}