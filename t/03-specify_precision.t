#!/usr/bin/perl
use strict;
use warnings;
use blib;  

# Test::Float  

use Test::Builder::Tester tests => 2;
use Test::Float within => 1e-4;

test_out("not ok 1 - foo");
test_fail(+2);
test_diag("0.0010 and 0.0020 are not equal to within 0.0001");
cmp_float(1e-3, 2e-3, "foo");
test_test("fail works");

test_out("ok 1 - foo");
cmp_float(1e-4, 2e-4, "foo");
test_test("ok works");

