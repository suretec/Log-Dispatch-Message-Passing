use strict;
use warnings;
use inc::Module::Install;
use Module::Install::Authority;
use Module::Install::AuthorRequires;
use Module::Install::AuthorTests;

all_from 'lib/Log/Dispatch/Log/Stash.pm';

license 'AGPL_3';

authority 'GHENRY';

requires 'Log::Stash';
requires 'Log::Dispatch';
requires 'Scalar::util';

test_requires 'Test::More' => '0.88';

author_requires 'Log::Message::Structured';
author_requires 'Test::Pod' => '1.14';
author_requires 'Test::NoTabs';
author_requires 'Test::Pod::Coverage' => '1.04';
author_requires 'Pod::Coverage' => '0.19';
author_requires 'Pod::Coverage::TrustPod';
author_requires 'Test::Spelling';

author_tests 't/author';

if ($Module::Install::AUTHOR) {
    system("pod2text lib/Log/Dispatch/Log/Stash.pm > README")
        and die $!;
}

WriteAll;

