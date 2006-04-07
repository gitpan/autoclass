package testNoAutoClass;
use strict;
use Class::AutoClass;
use vars
  qw(@ISA @AUTO_ATTRIBUTES @OTHER_ATTRIBUTES @CLASS_ATTRIBUTES %SYNONYMS %DEFAULTS);
#@ISA              = qw(Class::AutoClass);
@AUTO_ATTRIBUTES  = qw(name sex address dob a _b d real);
@OTHER_ATTRIBUTES = qw(b age);
@CLASS_ATTRIBUTES = qw(aa species population class_hash);
%SYNONYMS         = ( gender => 'sex', whatisya => 'sex', syn=>'real' );
%DEFAULTS = (
              a          => 'parent',
              b          => 'virtual parent',
              c          => 'default set in parent, used in kids',
              z          => 'default that is never used',
              species    => 'Dipodomys gravipes',
              population => 42,
              class_hash => {
                              this  => 'that',
                              these => 'those',
              }
);
Class::AutoClass::declare(__PACKAGE__);

sub new {
  my $class=shift @_;
  bless {},$class;
}
sub age { print "Calculate age from dob. NOT YET IMPLEMENTED\n"; undef }

1;
