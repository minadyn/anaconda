# Creates an environment with Anaconda, Python, and Numpy
# To add packages see anaconda::package

define anaconda::env(
  $anaconda_version=$anaconda::version,
  $numpy='1.7',
  $python=$anaconda::params::python_version,
  $base_path=$anaconda::install_path
) {
  if ! defined(Class['anaconda']) {
    fail('You must include the anaconda base class before using any anaconda defined resources')
  }
  $conda = "${base_path}/bin/conda"
  exec { "anaconda_env_${name}":
    command => "${conda} create -n ${name} anaconda=${anaconda_version} numpy=${numpy} python=${python} --yes --quiet",
    creates => "${base_path}/envs/${name}",
    require => Class["anaconda::install"],
    user => "${anaconda::conda_user}",
    logoutput => true,
  }
}