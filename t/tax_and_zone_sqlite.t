#!perl

use File::Spec;
use lib File::Spec->catdir( 't', 'lib' );

use Test::Roo;
with 'Test::Populate', 'Test::Zone', 'Test::Tax', 'Role::SQLite';

run_me;

done_testing;