package testPackage6;
use base qw(Class::AutoClass testPackage5);
use vars qw($package @AUTO_ATTRIBUTES @OTHER_ATTRIBUTES %SYNONYMS %DEFAULTS $CASE $age);
 
@AUTO_ATTRIBUTES=qw(first last friends sex has_default);
@OTHER_ATTRIBUTES=qw(age);
%DEFAULTS=(has_default=>'default value');
%SYNONYMS=(gender=>'sex');
$CASE='upper';
Class::AutoClass::declare(__PACKAGE__);

sub age {
  my $self = shift;
  my $age=@_? ($self->{age}=shift): $self->{age};
  return defined $age? $age: "NOT YET IMPLEMENTED";
}
 
sub _init_self {
   my($self,$class,$args)=@_;
   $self->{init_self_history} .= __PACKAGE__;
   return unless $class eq __PACKAGE__; # to prevent subclasses from re-running this
 }
1;
