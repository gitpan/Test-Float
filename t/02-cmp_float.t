#!/usr/bin/perl
use strict;
use warnings;
use blib;  

# Test::Float  

use Test::Builder::Tester tests => 2;
use Test::Float;

test_out("not ok 1 - foo");
test_fail(+2);
test_diag("0.000010 and 0.000020 are not equal to within 0.000001");
cmp_float(1e-5, 2e-5, "foo");
test_test("fail works");

test_out("ok 1 - foo");
cmp_float(1e-6, 2e-6, "foo");
test_test("ok works");

