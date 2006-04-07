use strict;
use lib qw(../lib t/);
use Test::More qw/no_plan/;
use Test::Deep;

# test handling of character case in attributes, etc.

BEGIN {
  use_ok('testCase_Parent');
  use_ok('testCaselower_Parent');
  use_ok('testCaseupper_Parent');
}

my @methods_exact=
  sort(qw(auto_lower AUTO_UPPER auto_MIXED
	  other_lower OTHER_UPPER other_MIXED
	  class_lower CLASS_UPPER class_MIXED
	  syn_lower SYN_UPPER syn_MIXED));
my @methods_lc=map {lc $_} grep /^auto|class/i,@methods_exact;
my @methods_uc=map {uc $_} grep /^auto|class/i,@methods_exact;
my @methods_randc=map {randc($_)} @methods_exact;
my @methods_all=uniq(@methods_exact,@methods_lc,@methods_uc,@methods_randc);

my ($parent, @can, @methods)=undef;

diag("test setting attributes from defaults");
$parent=new testCase_Parent;
@can=sort(uniq(grep {$parent->can($_)} @methods_all));
is_deeply(\@can,\@methods_exact,'parent can do expected methods');

is($parent->auto_lower,'auto_lower_default','auto_lower_default');
is($parent->AUTO_UPPER,'auto_upper_default','auto_upper_default');
is($parent->auto_MIXED,'auto_mixed_default','auto_mixed_default');

is($parent->other_lower,'other_lower_default','other_lower_default');
is($parent->OTHER_UPPER,'other_upper_default','other_upper_default');
is($parent->other_MIXED,'other_mixed_default','other_mixed_default');

is($parent->class_lower,'class_lower_default','class_lower_default');
is($parent->CLASS_UPPER,'class_upper_default','class_upper_default');
is($parent->class_MIXED,'class_mixed_default','class_mixed_default');

is($parent->syn_lower,'auto_lower_default','syn_lower_default');
is($parent->SYN_UPPER,'other_upper_default','syn_upper default');
is($parent->syn_MIXED,'class_mixed_default','syn_mixed_default');

($parent, @can, @methods)=undef;
$parent=new testCaselower_Parent;
@can=sort(uniq(grep {$parent->can($_)} @methods_all));
@methods=sort(uniq(@methods_exact,@methods_lc));
is_deeply(\@can,\@methods,'parent can do expected methods');

is($parent->auto_lower,'auto_lower_default','auto_lower_default: $CASE=\'lower\'');
is($parent->AUTO_UPPER,'auto_upper_default','auto_upper_default: $CASE=\'lower\'');
is($parent->auto_MIXED,'auto_mixed_default','auto_mixed_default: $CASE=\'lower\'');
is($parent->auto_upper,'auto_upper_default','lower case ok: $CASE=\'lower\'');
is($parent->auto_mixed,'auto_mixed_default','lower case ok: $CASE=\'lower\'');

is($parent->other_lower,'other_lower_default','other_lower_default: $CASE=\'lower\'');
is($parent->OTHER_UPPER,'other_upper_default','other_upper_default: $CASE=\'lower\'');
is($parent->other_MIXED,'other_mixed_default','other_mixed_default: $CASE=\'lower\'');

is($parent->class_lower,'class_lower_default','class_lower_default: $CASE=\'lower\'');
is($parent->CLASS_UPPER,'class_upper_default','class_upper_default: $CASE=\'lower\'');
is($parent->class_MIXED,'class_mixed_default','class_mixed_default: $CASE=\'lower\'');
is($parent->class_upper,'class_upper_default','lower case ok: $CASE=\'lower\'');
is($parent->class_mixed,'class_mixed_default','lower case ok: $CASE=\'lower\'');

is($parent->syn_lower,'auto_lower_default','syn_lower_default: $CASE=\'lower\'');
is($parent->SYN_UPPER,'other_upper_default','syn_upper default: $CASE=\'lower\'');
is($parent->syn_MIXED,'class_mixed_default','syn_mixed_default: $CASE=\'lower\'');

($parent, @can, @methods)=undef;
$parent=new testCaseupper_Parent;
@can=sort(uniq(grep {$parent->can($_)} @methods_all));
@methods=sort(uniq(@methods_exact,@methods_uc));
is_deeply(\@can,\@methods,'parent can do expected methods');

is($parent->auto_lower,'auto_lower_default','auto_lower_default: $CASE=\'upper\'');
is($parent->AUTO_UPPER,'auto_upper_default','auto_upper_default: $CASE=\'upper\'');
is($parent->auto_MIXED,'auto_mixed_default','auto_mixed_default: $CASE=\'upper\'');
is($parent->AUTO_UPPER,'auto_upper_default','upper case ok: $CASE=\'lower\'');
is($parent->AUTO_MIXED,'auto_mixed_default','aupper case ok: $CASE=\'lower\'');

is($parent->other_lower,'other_lower_default','other_lower_default: $CASE=\'upper\'');
is($parent->OTHER_UPPER,'other_upper_default','other_upper_default: $CASE=\'upper\'');
is($parent->other_MIXED,'other_mixed_default','other_mixed_default: $CASE=\'upper\'');

is($parent->class_lower,'class_lower_default','class_lower_default: $CASE=\'upper\'');
is($parent->CLASS_UPPER,'class_upper_default','class_upper_default: $CASE=\'upper\'');
is($parent->class_MIXED,'class_mixed_default','class_mixed_default: $CASE=\'upper\'');
is($parent->CLASS_UPPER,'class_upper_default','upper case ok: $CASE=\'lower\'');
is($parent->CLASS_MIXED,'class_mixed_default','upper case ok: $CASE=\'lower\'');

is($parent->syn_lower,'auto_lower_default','syn_lower_default: $CASE=\'upper\'');
is($parent->SYN_UPPER,'other_upper_default','syn_upper default: $CASE=\'upper\'');
is($parent->syn_MIXED,'class_mixed_default','syn_mixed_default: $CASE=\'upper\'');

($parent, @can, @methods)=undef;
diag("test setting attributes from arguments");
$parent=new testCase_Parent
  (auto_lower=>'auto_lower_arg',AUTO_UPPER=>'auto_upper_arg',auto_MIXED=>'auto_mixed_arg',
   other_lower=>'other_lower_arg',OTHER_UPPER=>'other_upper_arg',other_MIXED=>'other_mixed_arg',
   class_lower=>'class_lower_arg',CLASS_UPPER=>'class_upper_arg',class_MIXED=>'class_mixed_arg',
  );
@can=sort(uniq(grep {$parent->can($_)} @methods_all));
is_deeply(\@can,\@methods_exact,'parent can do expected methods');

is($parent->auto_lower,'auto_lower_arg','auto_lower_arg');
is($parent->AUTO_UPPER,'auto_upper_arg','auto_upper_arg');
is($parent->auto_MIXED,'auto_mixed_arg','auto_mixed_arg');

is($parent->other_lower,'other_lower_arg','other_lower_arg');
is($parent->OTHER_UPPER,'other_upper_arg','other_upper_arg');
is($parent->other_MIXED,'other_mixed_arg','other_mixed_arg');

is($parent->class_lower,'class_lower_arg','class_lower_arg');
is($parent->CLASS_UPPER,'class_upper_arg','class_upper_arg');
is($parent->class_MIXED,'class_mixed_arg','class_mixed_arg');

is($parent->syn_lower,'auto_lower_arg','syn_lower_arg');
is($parent->SYN_UPPER,'other_upper_arg','syn_upper arg');
is($parent->syn_MIXED,'class_mixed_arg','syn_mixed_arg');

($parent, @can, @methods)=undef;
$parent=new testCaselower_Parent
  (auto_lower=>'auto_lower_arg',auto_upper=>'auto_upper_arg',auto_mixed=>'auto_mixed_arg',
   other_lower=>'other_lower_arg',other_upper=>'other_upper_arg',other_mixed=>'other_mixed_arg',
   class_lower=>'class_lower_arg',class_upper=>'class_upper_arg',class_mixed=>'class_mixed_arg',
  );
@can=sort(uniq(grep {$parent->can($_)} @methods_all));
@methods=sort(uniq(@methods_exact,@methods_lc));
is_deeply(\@can,\@methods,'parent can do expected methods');

is($parent->auto_lower,'auto_lower_arg','auto_lower_arg: $CASE=\'lower\'');
is($parent->AUTO_UPPER,'auto_upper_arg','auto_upper_arg: $CASE=\'lower\'');
is($parent->auto_MIXED,'auto_mixed_arg','auto_mixed_arg: $CASE=\'lower\'');
is($parent->auto_upper,'auto_upper_arg','lower case ok: $CASE=\'lower\'');
is($parent->auto_mixed,'auto_mixed_arg','lower case ok: $CASE=\'lower\'');

is($parent->other_lower,'other_lower_arg','other_lower_arg: $CASE=\'lower\'');
is($parent->OTHER_UPPER,'other_upper_arg','other_upper_arg: $CASE=\'lower\'');
is($parent->other_MIXED,'other_mixed_arg','other_mixed_arg: $CASE=\'lower\'');

is($parent->class_lower,'class_lower_arg','class_lower_arg: $CASE=\'lower\'');
is($parent->CLASS_UPPER,'class_upper_arg','class_upper_arg: $CASE=\'lower\'');
is($parent->class_MIXED,'class_mixed_arg','class_mixed_arg: $CASE=\'lower\'');
is($parent->class_upper,'class_upper_arg','lower case ok: $CASE=\'lower\'');
is($parent->class_mixed,'class_mixed_arg','lower case ok: $CASE=\'lower\'');

is($parent->syn_lower,'auto_lower_arg','syn_lower_arg: $CASE=\'lower\'');
is($parent->SYN_UPPER,'other_upper_arg','syn_upper arg: $CASE=\'lower\'');
is($parent->syn_MIXED,'class_mixed_arg','syn_mixed_arg: $CASE=\'lower\'');

($parent, @can, @methods)=undef;
$parent=new testCaselower_Parent
  (syn_lower=>'auto_lower_arg',SYN_UPPER=>'other_upper_arg',syn_MIXED=>'class_mixed_arg');
is($parent->syn_lower,'auto_lower_arg','syn_lower_arg via syn: $CASE=\'lower\'');
is($parent->SYN_UPPER,'other_upper_arg','syn_upper arg via syn: $CASE=\'lower\'');
is($parent->syn_MIXED,'class_mixed_arg','syn_mixed_arg via syn: $CASE=\'lower\'');

($parent, @can, @methods)=undef;
$parent=new testCaseupper_Parent
  (AUTO_LOWER=>'auto_lower_arg',AUTO_UPPER=>'auto_upper_arg',AUTO_MIXED=>'auto_mixed_arg',
   OTHER_LOWER=>'other_lower_arg',OTHER_UPPER=>'other_upper_arg',OTHER_MIXED=>'other_mixed_arg',
   CLASS_LOWER=>'class_lower_arg',CLASS_UPPER=>'class_upper_arg',CLASS_MIXED=>'class_mixed_arg',
  );
@can=sort(uniq(grep {$parent->can($_)} @methods_all));
@methods=sort(uniq(@methods_exact,@methods_uc));
is_deeply(\@can,\@methods,'parent can do expected methods');

is($parent->auto_lower,'auto_lower_arg','auto_lower_arg: $CASE=\'upper\'');
is($parent->AUTO_UPPER,'auto_upper_arg','auto_upper_arg: $CASE=\'upper\'');
is($parent->auto_MIXED,'auto_mixed_arg','auto_mixed_arg: $CASE=\'upper\'');
is($parent->AUTO_UPPER,'auto_upper_arg','upper case ok: $CASE=\'lower\'');
is($parent->AUTO_MIXED,'auto_mixed_arg','aupper case ok: $CASE=\'lower\'');

is($parent->other_lower,'other_lower_arg','other_lower_arg: $CASE=\'upper\'');
is($parent->OTHER_UPPER,'other_upper_arg','other_upper_arg: $CASE=\'upper\'');
is($parent->other_MIXED,'other_mixed_arg','other_mixed_arg: $CASE=\'upper\'');

is($parent->class_lower,'class_lower_arg','class_lower_arg: $CASE=\'upper\'');
is($parent->CLASS_UPPER,'class_upper_arg','class_upper_arg: $CASE=\'upper\'');
is($parent->class_MIXED,'class_mixed_arg','class_mixed_arg: $CASE=\'upper\'');
is($parent->CLASS_UPPER,'class_upper_arg','upper case ok: $CASE=\'lower\'');
is($parent->CLASS_MIXED,'class_mixed_arg','upper case ok: $CASE=\'lower\'');

is($parent->syn_lower,'auto_lower_arg','syn_lower_arg: $CASE=\'upper\'');
is($parent->SYN_UPPER,'other_upper_arg','syn_upper arg: $CASE=\'upper\'');
is($parent->syn_MIXED,'class_mixed_arg','syn_mixed_arg: $CASE=\'upper\'');

($parent, @can, @methods)=undef;
$parent=new testCaseupper_Parent
  (syn_lower=>'auto_lower_arg',SYN_UPPER=>'other_upper_arg',syn_MIXED=>'class_mixed_arg');
is($parent->syn_lower,'auto_lower_arg','syn_lower_arg via syn: $CASE=\'upper\'');
is($parent->SYN_UPPER,'other_upper_arg','syn_upper arg via syn: $CASE=\'upper\'');
is($parent->syn_MIXED,'class_mixed_arg','syn_mixed_arg via syn: $CASE=\'upper\'');

sub randc {
  my($string)=@_;
  my @letters=split('',$string);
  $string=join('',map {int(rand 2)? uc $_: lc $_} @letters);
  $string;
}
sub uniq {my %h; @h{@_}=@_; values %h;}
