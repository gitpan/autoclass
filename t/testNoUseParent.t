use strict;
use lib qw(../lib t/);
use Test::More qw/no_plan/;
use Test::Deep;

# this is a regression test covering the use of a class that does not 'use' its
# parent class

BEGIN {
  use_ok('testNoUseParent');
}

my $child=new testNoUseParent;
isa_ok($child,'testNoUseParent','new');

# test instance attributes
is($child->a, 'child', 'instance default set in child');
is($child->b, 'virtual child', 'instance virtual default set in child');
is($child->c, 'default set in parent, used in kids', 'instance default set in parent, used in child');

# test class attributes
is($child->population,42,'class default set in parent');
cmp_deeply($child->class_hash,{bird  => 'robin', these => 'them'},'class default set in child');
