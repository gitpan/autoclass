use strict;
use lib qw(../lib t/);
use Override;
use Child;
use Test::More qw/no_plan/;

use Data::Dumper;

# this tests the ability to override the AutoClass object with another object (using the '_OVERRIDE__' flag)
my $over1 = new Override;
is(ref $over1, 'Override');
my $over2 = new Override(override=>1); # causes Override to set __OVERRIDE__ to true
is(ref $over2, 'Child');