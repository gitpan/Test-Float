package Test::Float;
use strict;
use warnings;
use vars qw ($VERSION @EXPORT);
$VERSION = "0.10";

# Required modules
use Carp;
use Test::Builder;

# Exporter
use base qw( Exporter );
@EXPORT = qw( cmp_float );

#--------------------------------------------------------------------------#
# main pod documentation #####
#--------------------------------------------------------------------------#

=head1 NAME

Test::Float - Compare if two numbers are equal within a specified precision

=head1 SYNOPSIS

  # Default precision
  use Test::Float;
  cmp_float( 1e-5, 2e-5, 'values within 1e-6'); # not ok
  
  # Specific precision
  use Test::Float within => 1e-5;
  cmp_float( 1e-5, 2e-5, 'values within 1e-5'); # ok

=head1 DESCRIPTION

Most programmers at one time or another are confronted with the 
issue of comparing floating-point numbers for equality.  The 
canonical idiom is to test if the absolute value of the difference
of the numbers is within a desired precision.  This module provides 
such a function for use with L<Test::Harness>.  Usage is similar 
to other test functions described in L<Test::More>.  Semantically,
the C<cmp_float> function replaces this kind of construct:

 ok ( abs($p - $q) <= $precision, '$p is equal to $q' ) or
     diag "$p is not equal to $q to within $precision";

While there's nothing wrong with that construct, it's a pain to 
type it repeatedly in a test script.  This module does the same thing
with a single function call.

=head1 USAGE

=head2 Importing

By default, C<use Test::Float> will compare equality with a precision of 1e-6.
(An arbitrary choice on my part.)  To specific a different precision, provide a
C<within> parameter when importing the module with C<use>:

 use Test::Float within => 1e-9;


=cut

my $Test = Test::Builder->new;
my $Precision = 1e-6;
my $PrintPrec;

sub import {
    my($self, %args) = @_;
    my $pack = caller;
    if (exists $args{within}) {
        $Precision = $args{within};
    }
    $PrintPrec = -log($Precision)/log(10);
    
    $Test->exported_to($pack);
    $self->export_to_level(1, $self, 'cmp_float');
}

#--------------------------------------------------------------------------#
# cmp_float()
#

=head2 cmp_float
 
 cmp_float( $p, $q, '$p and $q are equal' );

This test compares equality within the precision specified during
import (or the default of 1e-6).  The test is true if the absolute value
of the difference between $p and $q is B<less than or equal to> the
precision.  If the test is true, it prints an "OK" statement for use
in testing.  If the test is not true, this function prints a failure report 
and diagnostic.

=cut

sub cmp_float($$;$) {
	my ($p, $q, $name) = @_;

    return $Test->ok(abs($p - $q) <= $Precision,$name) || $Test->diag(
        sprintf("%.${PrintPrec}f and %.${PrintPrec}f are not equal to within %.${PrintPrec}f",
                $p, $q, $Precision));
}



1; #this line is important and will help the module return a true value
__END__

=head1 BUGS

Please report bugs using the CPAN Request Tracker at 
http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Float

=head1 AUTHOR

 David A. Golden (DAGOLDEN)
 david@dagolden.com
 http://dagolden.com/

=head1 COPYRIGHT

Copyright (c) 2004 by David A. Golden

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

L<Test::More>, L<Test::Harness>, L<Test::Builder>

=cut
