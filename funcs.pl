#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Funcs;

say sum(1 .. 10);
say sprintf '%.2f', sin($pi / 2);
say "@Fibonacci[8, 9, 10]";
say $french{Saturday};
