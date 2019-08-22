
# Change to the working directory
cd $WDIR

# Install a 'wmagent' virtual environment
virtualenv wmagent

source wmagent/bin/activate

# Install wmagent python pieces via pip
pip --no-cache-dir install wmagent

# exit the virtualenv
deactivate
