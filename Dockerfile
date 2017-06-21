# Debian build environment with GCC 6, ccache and all debian dev tools
#
# Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
# GPL licensed (see end of file) * Use at your own risk!
#
# Usage: 
#
#   docker run --rm  -v "/workdir/path:/src" -ti ownyourbits/debiandev
#
# Details at https://ownyourbits.com/2017/06/24/debian-build-environment-in-a-docker-container/

FROM ownyourbits/mmake:latest

LABEL description="Debian package development environment"
MAINTAINER Ignacio Núñez Hernanz <nacho@ownyourbits.com>

# install packages
RUN sudo sh -c "echo deb-src http://httpredir.debian.org/debian stretch main >> /etc/apt/sources.list"; \
    sudo apt-get update;\
    DEBIAN_FRONTEND=noninteractive sudo apt-get install --no-install-recommends -y dpkg-dev devscripts dh-make lintian fakeroot quilt eatmydata vim; \
    sudo apt-get autoremove -y; sudo apt-get clean; sudo rm /var/lib/apt/lists/*; \
    sudo rm /var/log/alternatives.log /var/log/apt/*; sudo rm /var/log/* -r;

# configure session
RUN echo "alias debuild='eatmydata debuild --prepend-path=/usr/lib/ccache --preserve-envvar=CCACHE_*'" >> /home/builder/.bashrc; \
    echo "alias dpkg-buildpackage='eatmydata dpkg-buildpackage'"                                       >> /home/builder/.bashrc; \
# NOTE: dpkg-buildpackage and debuild do not play well with colorgcc
    echo 'export PATH="/usr/lib/ccache/:$PATH"'; \
    sudo rm /usr/lib/colorgcc/*

COPY _quiltrc /home/builder/.quiltrc

# prepare work dir
RUN sudo mkdir -p /src; sudo chown builder:builder /src; echo 'cd /src' >> /home/builder/.bashrc

# remove previous entrypoint
ENTRYPOINT []

CMD ["/bin/bash"]

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

