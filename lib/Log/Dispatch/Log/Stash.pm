package Log::Dispatch::Log::Stash;
use base qw(Log::Dispatch::Output);

use warnings;
use strict;
use Carp qw/ confess /;

our $VERSION = '0.001';

sub new {
  my ($class, %arg) = @_;
  confess("Need an 'output' argument") unless $arg{output};

  my $self = { output => $arg{output} };

  bless $self => $class;

  # this is our duty as a well-behaved Log::Dispatch plugin
  $self->_basic_init(%arg);

  return $self;
}

sub log_message {
  my ($self, %p) = @_;
  $self->{output}->consume(%p);
}

=head1 NAME

Log::Dispatch::Log::Stash - log events to Log::Stash

=cut

=head1 SYNOPSIS

  use Log::Dispatch;
  use Log::Dispatch::Log::Stash;
  use Log::Stash::Output::ZeroMQ;
 
  my $log = Log::Dispatch->new;

  my $target = [];
 
  $log->add(Log::Dispatch::Log::Stash->new(
    name      => 'text_table',
    min_level => 'debug',
    output     => Log::Stash::Output::ZeroMQ->new(
    ),
  ));
 
  $log->warn($_) for @events;

  # now $target refers to an array of events

=head1 DESCRIPTION

This provides a Log::Dispatch log output system that sends logged events to
L<Log::Stash>.

=head1 METHODS

=head2 C<< new >>

 my $table_log = Log::Dispatch::Log::Stash->new(\%arg);

This method constructs a new Log::Dispatch::Log::Stash output object.

Required arguments are:

  output - a L<Log::Stash> OUTPUT class.

=head2 log_message

This is the method which performs the actual logging, as detailed by
Log::Dispatch::Output.

=cut

=head1 AUTHOR

Tomas Doran (t0m) C<< <bobtfish@bobtfish.net> >>

=head1 SPONSORSHIP

This module exists due to the wonderful people at
L<Suretec Systems|http://www.suretecsystems.com/> who sponsored it's
development.

=head1 COPYRIGHT

Copyright Suretec Systems 2012.

=head1 LICENSE

XXX - TODO

1;
