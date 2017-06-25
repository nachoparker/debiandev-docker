# PHP Debian build environment with GCC 6 and ccache, and all debian dev tools
#
# Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
# GPL licensed (see end of file) * Use at your own risk!
#
# Usage: 
#
#   docker run --rm  -v "src:/src" -ti ownyourbits/phpdev
#
# Then, inside:
#   cd php7.0-7.0.19
#   debuild -us -uc -b
#
# Note that with this invocation command, the code resides in a persistent volume called 'src'.
# See 'docker volume ls'
#
# It has already been build once with CCACHE, so you can just start tweaking, and recompilation will
# be very fast. If you do 'docker volume rm src', then next time you run the container it will be
# populated again with the fresh build ( but you would lose your code changes ).
#
# A second option is to do ` -v "/path:/src" and use "/path" from your system, but then you have to
# do 'apt-get source' and 'debuild' yourself, because "/path" will be originally empty.
#
# Details at https://ownyourbits.com/2017/06/24/debian-build-environment-in-a-docker-container/


FROM ownyourbits/raspbiandev:latest

LABEL description="PHP build environment"
MAINTAINER Ignacio Núñez Hernanz <nacho@ownyourbits.com>

## Get source
RUN sudo apt-get update;\
    mkdir -p /src; cd /src; \
    apt-get source php7.0-fpm; 

## PHP build dependencies
RUN sudo apt-get update;\
    DEBIAN_FRONTEND=noninteractive sudo apt-get build-dep -y -t stretch php7.0-fpm; \
    sudo apt-get autoremove -y; sudo apt-get clean; sudo rm /var/lib/apt/lists/*; \
    sudo rm /var/log/alternatives.log /var/log/apt/* ; sudo rm /var/log/* -r; sudo rm -rf /usr/share/man/*; 

## Build first
# this will build the package without testing but with the CCACHE options, so we are 
# building and catching compilation artifacts
RUN cd $( find /src -maxdepth 1 -type d | grep php ); \
    CCACHE_DIR=/src/.ccache DEB_BUILD_OPTIONS=nocheck \
    eatmydata debuild \
   --prepend-path=/usr/lib/ccache --preserve-envvar=CCACHE_* --no-lintian -us -uc; 


# License
#
# This script is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330,
# Boston, MA  02111-1307  USA
