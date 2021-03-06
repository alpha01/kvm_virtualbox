#!/usr/bin/env perl

# Written by Tony Baltazar. January 2014.
# Email: root[@]rubyninja.org

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

use strict;
use warnings;

use File::Basename;
use lib dirname(__FILE__) . '/lib';
use KVM::CreateVM;

use Getopt::Long;
#use Data::Dumper;


my %options;
GetOptions(\%options, "name|n:s", "disk|d:i", "memory|m:i", "help");

if ($options{help}) {
    usage();

} elsif ($options{name} && $options{disk} && $options{memory}) {
    my $new_vm = KVM::CreateVM->new(name => $options{name}, disk => $options{disk}, memory => $options{memory});
    $new_vm->hypervisor_type('kvm');
    $new_vm->create_vm("--pxe --noautoconsole --graphics keymap=en-us --autostart");
    #print Dumper($new_vm);

} else {
    usage();
}



sub usage {
print <<EOF;

$0: Creates a new KVM guest.

Syntax: $0 [--help|--name=<VM-name> --disk=<size-in-MB> --memory=<size-in-MB>]

   --help   | -h  : This help message
   --name   | -n  : Name of the new virtual machine instance.
   --disk   | -d  : Disk Size in MB.
   --memory | -m  : Memory in MB.

EOF
exit 1;
}
