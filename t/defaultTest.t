use strict;
use lib qw(../lib t/);
use Parent;
use Child;
use GrandChild;
use Test::More qw/no_plan/;

# this is a regression test covering a bug where the DEFAULTS set in a child class
# do not get correctly applied to attributes in the parent class

my $parent=new Parent;
my $child=new Child;
my $grandchild=new GrandChild;

is($parent->a, 'parent', 'parent has correct default setting');
is($child->a, 'child', 'child has correct default setting');
is($grandchild->a, 'grandchild', 'grandchild has correct default setting');

# NG 05-12-07: regression test for incorrect handling of defaults for 'virtual' attributes.
#              a virtual attribute is one that is implemented as a method and not
#              directly stored in the object

is($parent->b, 'virtual parent', 'parent has correct default setting for virtual attribute');
is($child->b, 'virtual child', 'child has correct default setting for virtual attribute');
is($grandchild->b, 'virtual grandchild', 'grandchild has correct default setting for virtual attribute');
my $c='default set in parent, used in kids';
is($child->c, $c, 'default set in parent, used in child');
is($grandchild->c, $c, 'default set in parent, used in grandchild');

my $d='default set in grandchild for attribute defined in parent';
ok(!$parent->d, 'default set in grandchild not seen in parent');
ok(!$child->d, 'default set in grandchild not seen in child');
is($grandchild->d, $d, 'default set in grandchild for attribute defined in parent');

$d='actual value set in new for attribute defined in parent';
$grandchild=new GrandChild(d=>$d);
is($grandchild->d,$d, "$d not overwritten by default defined in grandchild");

# NG 05-12-09: regression test for error in which defaults are stored directly
#              in object HASH, rather than being fed through methods
ok(!defined $parent->{'b'},'parent: virtual default  not stored in object HASH');
ok(!defined $parent->{'c'},'parent: default used in kids not stored in object HASH');
ok(!defined $parent->{'z'},'parent: unused default not stored in object HASH');
ok(!defined $child->{'b'},'child: virtual default  not stored in object HASH');
ok(!defined $child->{'z'},'child: unused default not stored in object HASH');
ok(!defined $grandchild->{'b'},'grandchild: virtual default  not stored in object HASH');
ok(!defined $grandchild->{'z'},'grandchild: unused default not stored in object HASH');


# NG 05-12-08:  regression test for incorrect handling of defaults for synonyms.
#               consider syn=>'real'. there are 6 cases
#               args nothing, defaults syn
#               args syn, defaults syn
#               args real, defaults syn
#               args nothing, defaults real
#               args syn, defaults real
#               args real, defaults real

use Parent_default_syn;
use Parent_default_real;
use Child_default_syn;
use Child_default_real;

diag('Tests for handling of defaults with  synonyms. Parent only');
my $case;
$case='args nothing, defaults syn';
$parent=new Parent_default_syn;
is($parent->syn,'default',"parent: $case");
$case='args syn, defaults syn';
$parent=new Parent_default_syn(-syn=>'arg');
is($parent->syn,'arg',"parent: $case");
$case='args real, defaults syn';
$parent=new Parent_default_syn(-real=>'arg');
is($parent->syn,'arg',"parent: $case");

$case='args nothing, defaults real';
$parent=new Parent_default_real;
is($parent->syn,'default',"parent: $case");
$case='args syn, defaults real';
$parent=new Parent_default_real(-syn=>'arg');
is($parent->syn,'arg',"parent: $case");
$case='args real, defaults real';
$parent=new Parent_default_real(-real=>'arg');
is($parent->syn,'arg',"parent: $case");


diag('Tests for handling of defaults with  synonyms. Parent and Child');
$case='args nothing, defaults syn';
$parent=new Parent;
$child=new Child_default_syn;
ok(!$parent->syn,"parent: $case");
is($child->syn,'default',"child: $case");
$case='args syn, defaults syn';
$parent=new Parent(-syn=>'arg');
$child=new Child_default_syn(-syn=>'arg');
is($parent->syn,'arg',"parent: $case");
is($child->syn,'arg',"child: $case");
$case='args real, defaults syn';
$parent=new Parent(-real=>'arg');
$child=new Child_default_syn(-real=>'arg');
is($parent->syn,'arg',"parent: $case");
is($child->syn,'arg',"child: $case");

$case='args nothing, defaults real';
$parent=new Parent;
$child=new Child_default_real;
ok(!$parent->syn,"parent: $case");
is($child->syn,'default',"child: $case");
$case='args syn, defaults real';
$parent=new Parent(-syn=>'arg');
$child=new Child_default_real(-syn=>'arg');
is($parent->syn,'arg',"parent: $case");
is($child->syn,'arg',"child: $case");
$case='args real, defaults real';
$parent=new Parent(-real=>'arg');
$child=new Child_default_real(-real=>'arg');
is($parent->syn,'arg',"parent: $case");
is($child->syn,'arg',"child: $case");

