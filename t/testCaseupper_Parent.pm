package testCaseupper_Parent;
use strict;
use Class::AutoClass;
use vars
  qw(@ISA @AUTO_ATTRIBUTES @OTHER_ATTRIBUTES @CLASS_ATTRIBUTES %SYNONYMS %DEFAULTS $CASE);
@ISA              = qw(Class::AutoClass);
@AUTO_ATTRIBUTES  = qw(auto_lower AUTO_UPPER auto_MIXED
		       _other_lower _other_upper _other_mixed);
@OTHER_ATTRIBUTES = qw(other_lower OTHER_UPPER other_MIXED);
@CLASS_ATTRIBUTES = qw(class_lower CLASS_UPPER class_MIXED);
%SYNONYMS         = ( syn_lower=>'auto_lower', 
		      SYN_UPPER=>'OTHER_UPPER',
		      syn_MIXED=>'class_MIXED');
%DEFAULTS = (AUTO_LOWER=>'auto_lower_default',
	     auto_UPPER=>'auto_upper_default',
	     auto_mixed=>'auto_mixed_default',
	     other_LOWER=>'other_lower_default',
	     other_upper=>'other_upper_default',
	     OTHER_MIXED=>'other_mixed_default',
	     CLASS_LOWER=>'class_lower_default',
	     class_UPPER=>'class_upper_default',
	     CLASS_mixed=>'class_mixed_default',

	    );
$CASE='upper';
Class::AutoClass::declare(__PACKAGE__,$CASE);

sub other_lower {my $self=shift @_; @_? $self->_other_lower(@_): $self->_other_lower;}
sub OTHER_UPPER {my $self=shift @_; @_? $self->_other_upper(@_): $self->_other_upper;}
sub other_MIXED {my $self=shift @_; @_? $self->_other_mixed(@_): $self->_other_mixed;}


1;
