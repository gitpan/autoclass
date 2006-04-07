use strict;
use lib qw(../lib t/);
use Test::More qw/no_plan/;

# this is a regression test covering the use of a class that does not inherit from AutoClass
# we don't really care what happens, so long as it doesn't crash

BEGIN {
  use_ok('testNoAutoClass');
}

my $object =new testNoAutoClass;
isa_ok($object,'testNoAutoClass','new');

# test instance attributes
ok($object->can('a'),'instance attribute defined');
is($object->a(12345),12345,'instance attribute can be set');
is($object->a,12345,'instance attribute can be gotten');

# test class attributes
ok($object->can('aa'),'class attribute defined');
is($object->aa(12345),12345,'class attribute can be set');
is($object->aa,12345,'class attribute can be gotten');

