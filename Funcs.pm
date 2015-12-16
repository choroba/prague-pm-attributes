package Funcs;

=head1 NAME

Funcs

=cut

use warnings;
use strict;

use Export::Attr;

sub sum :Export {
    my $s = 0;
    $s += $_ for @_;
    return $s
}

our $pi :Export = 22 / 7;

our @Fibonacci :Export = (1, 1);
push @Fibonacci, $Fibonacci[$_ - 1] + $Fibonacci[$_ - 2] for 2 .. 10;

our %french :Export = ( Monday    => 'Lundi',
                        Tuesday   => 'Mardi',
                        Wednesday => 'Mercredi',
                        Thursday  => 'Jeudi',
                        Friday    => 'Vendredi',
                        Saturday  => 'Samedi',
                        Sunday    => 'Dimanche');

__PACKAGE__
