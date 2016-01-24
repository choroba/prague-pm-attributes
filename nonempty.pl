#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Array::Nonempty;
    use Tie::Array;
    use parent -norequire => 'Tie::StdArray';
    use Carp;

    sub CLEAR {
        my $self = shift;
        $self->[0] = [];
    }

    sub TIEARRAY {
        my ($class, $referer) = @_;
        bless [ [], $referer ], $class
    }

    sub EXTEND {
        my ($self, $size) = @_;
        croak "Cannot be empty" if 0 == @{ $self->[0] } && 0 == $size;
        $self->SUPER::EXTEND($size);
        my $tied = $self->[1];

        # Prevent "untie attempted while 1 inner references still exist"
        undef $self;

        untie @$tied;
    }
}


{   package UNIVERSAL;
    use Attribute::Handlers autotieref => { Nonempty => 'Array::Nonempty' };
}


my %hash_ok = ( answer => 42 );
my %hash_empty = ();

my @keys_ok :Nonempty = keys %hash_ok;
say tied(@keys_ok) // 'not tied';
say for @keys_ok;

my @keys_empty :Nonempty = keys %hash_empty;
