#!/bin/bash
############################################################################
#                                                                          #
# This file is part of the IPFire Firewall.                                #
#                                                                          #
# IPFire is free software; you can redistribute it and/or modify           #
# it under the terms of the GNU General Public License as published by     #
# the Free Software Foundation; either version 3 of the License, or        #
# (at your option) any later version.                                      #
#                                                                          #
# IPFire is distributed in the hope that it will be useful,                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of           #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
# GNU General Public License for more details.                             #
#                                                                          #
# You should have received a copy of the GNU General Public License        #
# along with IPFire; if not, write to the Free Software                    #
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA #
#                                                                          #
# Copyright (C) 2010 IPFire-Team <info@ipfire.org>.                        #
#                                                                          #
############################################################################
#
. /opt/pakfire/lib/functions.sh
/usr/local/bin/backupctrl exclude >/dev/null 2>&1
#
#Stop services
/etc/init.d/sshd stop
#
#Extract files
extract_files
#
#Start services
/etc/init.d/sshd start
/etc/init.d/apache reload
#
#Delete cyrus-sasl metafiles
rm -f /opt/pakfire/db/installed/meta-cyrus-sasl
rm -f /opt/pakfire/db/meta/meta-cyrus-sasl
#
#Update Language cache
perl -e "require '/var/ipfire/lang.pl'; &Lang::BuildCacheLang"

#
#Run depmod to rebuld module informations
#depmod 2.6.27.42-ipfire
#depmod 2.6.27.42-ipfire-xen
#Finish
#Don't report the exitcode last command
exit 0
