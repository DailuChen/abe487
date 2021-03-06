#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use feature 'say';
use Getopt::Long;
use Pod::Usage;
use Bio::SearchIO;

my %opts = get_opts();

if ($opts{'help'} || $opts{'man'}) {
    pod2usage({
        -exitval => 0,
        -verbose => $opts{'man'} ? 2 : 1
    });
}

my $blast_output = shift || pod2usage();
my $object = Bio::SearchIO->new(
    -file => $blast_output,
    -format => 'blast'
);
say join "\t", qw[query hit evalue];

my $seq_val = 1e-50;
while (my $result = $object->next_result) {
    while (my $hit = $result->next_hit) {
        my $hitsig = $hit->significance;
            if ($hitsig <= $seq_val) {
                while (my $hsp = $hit->next_hsp) {
                    my $query_name = $hsp->query_string;
                    my $hit_name = $hsp->hit_string;
                    my $evalue = $hsp->evalue;
                    say join "\t", $query_name, $hit_name, $evalue;
            }   
        }
    }
}


# --------------------------------------------------
sub get_opts {
    my %opts;
    GetOptions(
        \%opts,
        'help',
        'man',
    ) or pod2usage(2);

    return %opts;
}

__END__

# --------------------------------------------------

=pod

=head1 NAME

01-bio-searchio.pl - a script

=head1 SYNOPSIS

  01-bio-searchio.pl 

Options:

  --help   Show brief help and exit
  --man    Show full documentation

=head1 DESCRIPTION

Describe what the script does, what input it expects, what output it
creates, etc.

=head1 SEE ALSO

perl.

=head1 AUTHOR

Dai Lu Chen E<lt>dailu@email.arizona.eduE<gt>.

=head1 COPYRIGHT

Copyright (c) 2015 dailu

This module is free software; you can redistribute it and/or
modify it under the terms of the GPL (either version 1, or at
your option, any later version) or the Artistic License 2.0.
Refer to LICENSE for the full license text and to DISCLAIMER for
additional warranty disclaimers.

=cut
