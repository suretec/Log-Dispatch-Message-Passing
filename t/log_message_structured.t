use strict;
use warnings;
use FindBin qw/ $Bin /;
use lib "$Bin/lib";

use Test::More;

BEGIN {
    plan skip_all => 'Need Log::Message::Structured'
        unless do { local $@; eval { require Log::Message::Structured } };
}

use JSON qw/ decode_json /;
use TestStorage;
use Log::Dispatch;
use Log::Dispatch::Log::Stash;
use Log::Stash::Output::Test;

my $log = Log::Dispatch->new;

my $test = Log::Stash::Output::Test->new;

$log->add(Log::Dispatch::Log::Stash->new(
    name      => 'myapp_logstash',
    min_level => 'debug',
    output     => $test,
));
$log->warn(TestStorage->new(foo => "bar"));

is $test->message_count, 1;
my ($msg) = $test->messages;
my $data = decode_json(delete($msg->{message}));
is_deeply $msg, {level => 'warn', name => 'myapp_logstash'};
is $data->{__CLASS__}, 'TestStorage';

done_testing;

