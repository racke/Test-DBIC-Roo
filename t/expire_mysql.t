#!perl

use File::Spec;
use lib File::Spec->catdir( 't', 'lib' );

use Test::Roo;
with 'Test::Expire', 'Role::MySQL';

run_me;

done_testing;
