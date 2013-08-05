class anaconda(
  $install_path = $anaconda::params::install_path,
  $version = $anaconda::params::version,
  $conda_user = $anaconda::params::conda_user,
  $conda_group = $anaconda::params::conda_group
) inherits anaconda::params {
  $installer = $kernel ? {
    'linux'   => "Anaconda-${version}-Linux-x86_64.sh",
    'windows' => "Anaconda-${version}-Windows-x86_64.exe",
    'Darwin'  => "Anaconda-${version}-MacOSX-x86_64.sh",
  }

  $url = "${anaconda::params::base_url}/${installer}"

  class { 'anaconda::install':

  }
}
