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
  $self->{output}->consume({%p});
}

=head1 NAME

Log::Dispatch::Log::Stash - log events to Log::Stash

=head1 SYNOPSIS

In your application code:

  use Log::Dispatch;
  use Log::Dispatch::Log::Stash;
  use Log::Stash::DSL;

  my $log = Log::Dispatch->new;

  $log->add(Log::Dispatch::Log::Stash->new(
        name      => 'myapp_aggregate_log',
        min_level => 'debug',
        output    => log_chain {
            output zmq => (
                class => 'ZeroMQ',
                connect => 'tcp://192.168.0.1:5558',
            );
        },
  ));

  $log->warn($_) for qw/ foo bar baz /;

On your central log server:

  logstash --input ZeroMQ --input_options '{"socket_bind":"tcp://*:5558"}' --output STDOUT > myapp_aggregate.log

=head1 DESCRIPTION

This provides a Log::Dispatch log output system that sends logged events to
L<Log::Stash>.

This allows you to use any of the Log::Stash emitters or filters
to process log events and send them across the network, and you can use
the toolkit to trivially construct a log aggregator.

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

=head1 SEE ALSO

=over

=item L<Log::Stash>

The logging framework itself, allowing you to very simply build log
aggregation and processing servers.

=item L<Log::Stash::Output::ZeroMQ>

The recommended network protocol for aggregating or transporting messages
across the network.

Note that whilst this transport is recommended, it is B<NOT> required by
this module, so you need to require (and depend on) L<Log::Stash::ZeroMQ>
separately.

=item example/ directory

Instantly runnable SYNOPSIS - plug into your application for easy log
aggregation.

=back

=head1 AUTHOR

Tomas Doran (t0m) C<< <bobtfish@bobtfish.net> >>

=head1 SPONSORSHIP

This module exists due to the wonderful people at
L<Suretec Systems|http://www.suretecsystems.com/> who sponsored it's
development.

=head1 COPYRIGHT

Copyright Suretec Systems 2012.

=head1 LICENSE

GNU Affero General Public License, Version 3

If you feel this is too restrictive to be able to use this software,
please talk to us as we'd be willing to consider re-licensing under
less restrictive terms.

=cut

1;

