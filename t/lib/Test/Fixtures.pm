package Test::Fixtures;

use Test::Exception;
use Test::Roo::Role;

test 'jobs' => sub {
    my $self = shift;
    my $schema = $self->schema;

    cmp_ok ( $self->jobs->find ( { name => 'dancer' } )->description,
             'eq', 'Perl Dancer programmer', "job description for dancer" );
};

1;
