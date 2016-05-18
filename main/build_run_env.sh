#
# Variable definition common for docker build, run
#
REPO_NAME=meteosatlib
REPO_TAG=1.3

# Get encrypted password like so where the 2nd argument are
# two characters randomly chosen from 
# "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
# python -c 'import crypt; print crypt.crypt("password","9a")'
APPUSER=mesa
APPUID=${SUDO_UID:-`id -u`}
APPPASS='9aMhlX4Bavhfw'

HOME_DIR="${HOME_DIR:-$PWD/..}"

