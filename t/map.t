#!perl

package Sample;

use strict;use warnings;
use Moo;
use namespace::clean;

has xml => (is => 'ro', default => sub { return File::Spec->catfile('t', 'sample.xml') });
with 'Map::Tube';

package main;

use strict;use warnings;
use Test::More;
use Sample;
use Test::Map::Tube;

ok_map(Sample->new);
