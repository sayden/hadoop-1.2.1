#
# PUPPET CONFIGURATION FOR A HADOOP 0.20 SLAVE NODE
#

# Install git
package {'git': ensure => installed }

# Clone hadoop repository
exec {'clone-repository': 
	command => '/usr/bin/git clone https://github.com/sayden/hadoop-0.20.git /var/hadoop',
	require => Package['git'],
	unless => '/usr/bin/test -e /var/hadoop'
}

# Set the file permissions to Hadoop directory
file { "/var/hadoop":
	recurse => true,
	owner => "vagrant",
	group => "vagrant",
}

# Open Firewall ports
exec {'open-firewall':
	command =>'/usr/bin/service firewalld stop',
	onlyif => '/usr/bin/test -e /lib/systemd/system/firewalld.service'
}

# Create hdfs dir
exec {'create-hdfs-dir':
	command => '/bin/mkdir /var/hadoop/hdfs',
	require => Exec['clone-repository'],
	unless => "/usr/bin/test -e /var/hadoop/hdfs"
}

# Create a pass less key for ssh access. Access must be from 
# master -> master and master -> slaves
# Configure first the master -> master access
exec{'master-to-master-ssh-access':
	command => '/usr/bin/ssh-keygen -t rsa -P "" -f /home/vagrant/.ssh/passless',
	unless => '/usr/bin/test -f /home/vagrant/.ssh/passless'
}

# Install Java
package{'openjdk-6-jdk': ensure => installed}