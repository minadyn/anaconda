class anaconda::install (

) inherits anaconda::params {
  # Bug fix: the require will force a download even if it doesn't have to be installed
  Exec { path => "${anaconda::params::install_path}/bin:/usr/bin:/usr/sbin/:/bin:/sbin" }
  exec { "install_anaconda":
    command => "bash /tmp/${anaconda::installer} -b -p ${anaconda::install_path}",
    creates => "${anaconda::install_path}",
    require => Exec["download_anaconda"],
    user => "${anaconda::conda_user}",
    group => "${anaconda::conda_group}",
  }

  # Bug fix: the onlyif prevents the download from happening
  # when it doesn't need to be installed
  # Avoid circular dependency on "install_anaconda", run if /opt/anaconda doesn't exist
  exec { "download_anaconda":
    command => "wget -P /tmp ${anaconda::url}",
    creates => "/tmp/${anaconda::installer}",
    onlyif  => "test ! -d ${anaconda::install_path}",
    # download could take a while
    timeout => 0,
  }

  file { "${anaconda::install_path}/.condarc":
      source => "puppet:///modules/anaconda/.condarc",
      ensure => present,
      require => Exec["install_anaconda"],
  }
}
