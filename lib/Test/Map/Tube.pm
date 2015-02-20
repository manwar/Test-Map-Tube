package Test::Map::Tube;

$Test::Map::Tube::VERSION   = '0.01';
$Test::Map::Tube::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Test::Map::Tube - Interface to test Map::Tube (map data).

=head1 VERSION

Version 0.01

=cut

use strict; use warnings;
use 5.006;
use Test::Builder;

my $TEST      = Test::Builder->new;
my $TEST_BOOL = 1;
my $PLAN      = 0;

=head1 DESCRIPTION

It's main responsibilty is to  validate the map data (xml) as used by the package
that takes the role of L<Map::Tube>.

=head1 SYNOPSIS

Below is the sample code from L<Map::Tube::London> as an example:

    use strict; use warnings;
    use Test::More;
    use Map::Tube::London;

    eval "use Test::Map::Tube";
    plan skip_all => "Skipping, required Test::Map::Tube" if $@;

    ok_map(Map::Tube::London->new);

=cut

sub import {
    my ($self, %plan) = @_;
    my $caller = caller;

    foreach my $function (qw(ok_map)) {
        no strict 'refs';
        *{$caller."::".$function} = \&$function;
    }

    $TEST->exported_to($caller);
    $TEST->plan(%plan);

    $PLAN = 1 if (exists $plan{tests});
}

=head1 METHODS

=head2 ok_map($map_object, $message)

It expects an object of package that has take the role of L<Map::Tube>.Optionally
a C<$message> can also be passed in.

=cut

sub ok_map ($;$) {
    my ($object, $message) = @_;

    $TEST->plan(tests => 1) unless $PLAN;
    $TEST->is_num(_validate($object), $TEST_BOOL, $message);
}

#
#
# PRIVATE METHODS

sub _validate {
    my ($object) = @_;

    return 0 unless (defined $object && $object->does('Map::Tube'));

    eval { $object->_validate_map_data; };
    ($@)?(return 0):(return 1);
}

=head1 BUGS

None that I am aware of.Of course, if you find a bug, let me know, and I would do
my best  to fix it.  This is still a very early version, so it is always possible
that I have just "gotten it wrong" in some places.

=head1 SEE ALSO

=over 4

=item L<Map::Tube>

=back

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 REPOSITORY

L<https://github.com/Manwar/Test-Map-Tube>

=head1 BUGS

Please report any bugs / feature requests to C<bug-test-map-tube at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Map-Tube>.
I will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Map::Tube

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Map-Tube>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Map-Tube>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Map-Tube>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Map-Tube/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2015 Mohammad S Anwar.

This  program  is  free software; you can redistribute it  and/or modify it under
the  terms  of the the Artistic License (2.0). You may  obtain a copy of the full
license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any  use,  modification, and distribution of the Standard or Modified Versions is
governed by this Artistic License.By using, modifying or distributing the Package,
you accept this license. Do not use, modify, or distribute the Package, if you do
not accept this license.

If your Modified Version has been derived from a Modified Version made by someone
other than you,you are nevertheless required to ensure that your Modified Version
 complies with the requirements of this license.

This  license  does  not grant you the right to use any trademark,  service mark,
tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge patent license
to make,  have made, use,  offer to sell, sell, import and otherwise transfer the
Package with respect to any patent claims licensable by the Copyright Holder that
are  necessarily  infringed  by  the  Package. If you institute patent litigation
(including  a  cross-claim  or  counterclaim) against any party alleging that the
Package constitutes direct or contributory patent infringement,then this Artistic
License to you shall terminate on the date that such litigation is filed.

Disclaimer  of  Warranty:  THE  PACKAGE  IS  PROVIDED BY THE COPYRIGHT HOLDER AND
CONTRIBUTORS  "AS IS'  AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES. THE IMPLIED
WARRANTIES    OF   MERCHANTABILITY,   FITNESS   FOR   A   PARTICULAR  PURPOSE, OR
NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY YOUR LOCAL LAW. UNLESS
REQUIRED BY LAW, NO COPYRIGHT HOLDER OR CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL,  OR CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE
OF THE PACKAGE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

1; # End of Test::Map::Tube
