# Creates an environment with Anaconda, Python, and Numpy
# To add packages see anaconda::package

define anaconda::env( $anaconda_version='1.5', $numpy='1.7', $python='2.7',
                    $base_path='/opt/anaconda') {
    include anaconda
    
    $conda = "${base_path}/bin/conda"
    
    exec { "anaconda_env_${name}":
        command => "$conda create --yes --quiet \
                    --name=${name} anaconda=${anaconda_version} numpy=${numpy} \
                    python=${python}",
        creates => "${base_path}/envs/${name}",
        require => Class["anaconda::install"],
    }
}