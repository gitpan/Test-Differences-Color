#!/usr/bin/env perl
#===============================================================================
#       AUTHOR:  Alec Chen , <alec@cpan.org>
#===============================================================================

use strict;
use warnings;
use Test::More tests => 1;
use Test::Differences::Color;

my $data1 = {
    a => 0,
    b => [2,3],
    c => {
        x => 100,
        y => 200,
        z => 300,
    },
};

my $data2 = {
    a => 1,
    b => [2,3],
    c => {
        x => 101,
        y => 200,
        z => 300,
    },
};

eq_or_diff($data1, $data2);
