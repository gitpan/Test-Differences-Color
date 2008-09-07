package Test::Differences::Color;

use Sub::Override;
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;

use Exporter 'import';
our @EXPORT = qw(eq_or_diff);

=head1 NAME

Test::Differences::Color - colorize output of Test::Differences

=head1 VERSION

Version 0.02

=cut

use version; our $VERSION = qv('0.02');

=head1 SYNOPSIS

    use Test::More tests => 1;
    use Test::Differences::Color;

    eq_or_diff(\%hash1, \@hash2);

=head1 EXPORT

=head2 eq_or_diff

=head1 FUNCTIONS

=head2 eq_or_diff

see L<Test::Differences>

=cut

sub eq_or_diff {
    my ($data1, $data2) = @_;
    my(undef, $file, $line_num) = caller;

    my $override = Sub::Override->new();
    $override->replace('Test::Builder::_print_diag', 
        sub {
            my ($self, $msg)= @_;

            local($\, $", $,) = (undef, ' ', '');
            my $fh = $self->todo ? $self->todo_output : $self->failure_output;


            my $type = $self->todo ? 'Fail (TODO)' : 'Failed';
            my @lines = split /\n/, $msg;

            if ($msg =~ /Failed/) {
                shift @lines;
                unshift @lines, qq{# $type test at $file line $line_num.};
            }

            foreach my $line (@lines) {
                my $match_start = $line =~ /^# \*/;
                my $match_end   = $line =~ /\*$/;
                if ($match_start && $match_end) {
                    print $fh ON_RED "$line\n";
                }
                elsif ($match_start) {
                    print $fh ON_BLUE "$line\n";
                }
                elsif ($match_end) {
                    print $fh ON_GREEN "$line\n";
                }
                else {
                    print $fh "$line\n";
                }
            }
        },   
    );

    require Test::Differences;
    Test::Differences::eq_or_diff($data1, $data2);
    $override->restore();
}

=head1 SEE ALSO

L<Test::Differences>

=head1 AUTHOR

Alec Chen, C<< <alec at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-test-differences-color at rt.cpan.org>, or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Differences-Color>. I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Differences::Color

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Differences-Color>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Differences-Color>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Differences-Color>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Differences-Color>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 Alec Chen, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Test::Differences::Color
