use strict;
use warnings;

use Test::More;

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

$log->warn("foo");

is $test->message_count, 1;
is_deeply [$test->messages], [{level => 'warn', name => 'myapp_logstash', message => 'foo'}];

done_testing;

