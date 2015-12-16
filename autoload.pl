#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Array::Nonempty;
    use Tie::Array;
    use Carp;

    use Data::Dumper;

    our $AUTOLOAD;
    sub AUTOLOAD {
        (my $method = $AUTOLOAD) =~ s/.*:://;
        warn "$method ", Dumper \@_;
        my $sub = do {
            no strict 'refs';
            *{ "Tie::StdArray::$method" }
        };
        if (exists &$sub) {
            $sub->(@_);
        } else {
            warn "$sub not found";
        }
    }

}


{   package UNIVERSAL;
    use Attribute::Handlers autotie => { Nonempty => 'Array::Nonempty' };
}


my @arr :Nonempty = (1 .. 10);
shift @arr;
pop @arr;
