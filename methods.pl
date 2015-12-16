#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };


{   package Method::Types;

    use Carp;
    use Attribute::Handlers;

    sub handler {
        my ($package, $symbol, $ref, $attr, $data, $phase) = @_;
        die if 'CHECK' ne $phase;

        my $method_type   = { Class    => 'static',
                              Instance => 'instance',
                            }->{$attr};

        {   no warnings 'redefine';
            *$symbol = sub {
                croak("Can't call $method_type method '", *{$symbol}{NAME},
                      "' on ", ref $_[0] ? 'an object' : 'a class',
                      ".\n") if ref $_[0] xor 'instance' eq $method_type;
                goto $ref
            };
        }
    }

    sub Class : ATTR(CODE) { handler(@_) }

    sub Instance : ATTR(CODE) { handler(@_) }

}

{   package Named;
    use parent -norequire => 'Method::Types';

    sub new : Class {
        bless {}, shift
    }

    sub set_name : Instance {
        $_[0]->{name} = $_[1]
    }

    sub get_name : Instance {
        shift->{name}
    }
}

my $o = 'Named'->new;
$o->set_name('John');
say $o->get_name;
eval {$o->new; 1} or warn $@;
eval {'Named'->get_name; 1} or warn $@;
