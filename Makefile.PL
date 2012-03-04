use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Log/Dispatch/Log/Stash.pm';

license 'AGPL_3';

requires 'Log::Stash';
requires 'Log::Dispatch';

test_requires 'Test::More' => '0.88';

WriteAll;

