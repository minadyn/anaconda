# Class anaconda::params
#
# This class manages Anaconda parameters
#

class anaconda::params {
  $install_path = '/opt/anaconda'
  $version = '1.6.1'
  $python_version = '2.7'
  $base_url = $domain ? {
    'atx.continuum.io'=>"http://filer.atx.continuum.io/released/1.5.0",
    default           =>"http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com",
  }
  $conda_user = 'vagrant'
  $conda_group = 'vagrant'
}