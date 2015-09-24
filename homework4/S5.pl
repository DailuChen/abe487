#!/usr/bin/perl

use strict;
use warnings;

while (my $line = <>) {
    my $Nobody = index($line,'Nobody');
    my $somebody = index($line,'somebody');
    if ($Nobody >= 0) {
	warn("Nobody is here: $Nobody\n");
    }
    if ($somebody >= 0) {
	warn("somebody is here: $somebody\n");
    }
    
}   
