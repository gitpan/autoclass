use strict;
use lib qw(../lib t/);
use Test::More qw/no_plan/;
use Test::Deep;

# test inconsistent attributes -- ones declared as both instance and class attributes
# note that error is detected at 'declare time' during use

eval "use testInconsistent1";

ok(!$@,'use testInconsistent1 found no inconsistencies');
eval "use testInconsistent2";
like($@,qr/^Inconsistent declarations for attribute\(s\) a b/,
     'use testInconsistent2 found expected inconsistencies');
