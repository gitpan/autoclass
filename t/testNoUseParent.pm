package testNoUseParent;
use strict;
use Class::AutoClass;
# use Parent;  # do NOT use Parent!! this is the whole point of the test!!!
use vars
  qw(@ISA @AUTO_ATTRIBUTES @OTHER_ATTRIBUTES @CLASS_ATTRIBUTES %SYNONYMS %DEFAULTS);
@ISA              = qw(Class::AutoClass Parent);
@AUTO_ATTRIBUTES  = qw(c);
@OTHER_ATTRIBUTES = qw();
@CLASS_ATTRIBUTES = qw(species class_hash);
%SYNONYMS         = ();
%DEFAULTS = (
              a          => 'child',
              b          => 'virtual child',
              class_hash => {
                              bird  => 'robin',
                              these => 'them',
              },
);
Class::AutoClass::declare(__PACKAGE__);

sub _init_self {
 my ( $self, $class, $args ) = @_;
 return
   unless $class eq __PACKAGE__;    # to prevent subclasses from re-running this
}
1;
