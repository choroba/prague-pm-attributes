package Export::Attr;

=head1 NAME

ExportAttr

=cut

use warnings;
use strict;

use Attribute::Handlers;


my %pushed;
sub UNIVERSAL::Export :ATTR(BEGIN) {
    my ($package, $ref, $type) = @_;
    (my $symbol = $$ref) =~ s/^.*:://;
    my $sigil = { SCALAR => '$',
                  ARRAY  => '@',
                  HASH   => '%',
                  CODE   => q(),
                }->{ref $type};

    {   no strict 'refs';
        if (! $pushed{$package}) {
            push @{"$package\::ISA"}, 'Exporter';
            $pushed{$package} = 1;
        }
        push @{"$package\::EXPORT"}, $sigil . $symbol;
    }

}

__PACKAGE__
