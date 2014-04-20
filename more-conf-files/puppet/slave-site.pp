#
# PUPPET CONFIGURATION FOR A HADOOP 0.20 SLAVE NODE
#

# Install git
package {'git': ensure => installed }

# Clone hadoop repository
exec {'clone-repository':
        command => '/usr/bin/git clone https://github.com/sayden/hadoop-0.20.git /var/hadoop',
        require => Package['git'], 
        unless => '/usr/bin/test -f /var/hadoop'
}

# Set the file permissions to Hadoop directory
file { "/var/hadoop":
  recurse => true,
  owner => "vagrant",
  group => "vagrant",
}

# Open Firewall ports
exec {'open-firewall':
        command =>'/usr/bin/service firewalld stop'
}

# Create hdfs dir
exec {'create-hdfs-dir':
        command => '/bin/mkdir /var/hadoop/hdfs',
        require => Exec['clone-repository'],
        unless => "/usr/bin/test -f /var/hadoop/hdfs"
}