#!/usr/bin/perl
use strict;
use warnings;
use blib;  

# Test::Float  

use Test::More tests => 2;

BEGIN { use_ok( 'Test::Float'); }
can_ok( 'Test::Float', 'cmp_float' ); 

