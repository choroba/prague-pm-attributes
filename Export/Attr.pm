package Export::Attr;

=head1 NAME

ExportAttr

=cut

use warnings;
use strict;

use Attribute::Handlers;

sub UNIVERSAL::Export :ATTR(BEGIN) {
    my ($package, $ref, $type) = @_;
    (my $symbol = $$ref) =~ s/^.*:://;
    my $sigil = { SCALAR => '$',
                  ARRAY  => '@',
                  HASH   => '%',
                }->{ref $type} || q();

    {   no strict 'refs';
        push @{"$package\::ISA"}, 'Exporter';
        push @{"$package\::EXPORT"}, $sigil . $symbol;
    }

}

__PACKAGE__
