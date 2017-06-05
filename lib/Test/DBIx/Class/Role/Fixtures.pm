package Test::DBIx::Class::Role::Fixtures;
use utf8;

use Sub::Quote qw/quote_sub/;
use Moo::Role;

# accessors are ordered in this array based on the order in which
# clear_all_fixtures needs to receive them so that there are no FK issues in
# the database during row deletion

my @accessors = qw(jobs);

# we also need a package global mapping of accessor to result class

our %accessor2class = (
    jobs => 'Job',
);

# Create all of the accessors and clearers. Builders should be defined later.

foreach my $accessor (@accessors) {
    has $accessor => (
        is        => 'lazy',
        clearer   => "_clear_$accessor",
        predicate => 1,
    );

    my $cref = q{
        my $self = shift;
        $self->schema->resultset($class)->delete;
        my $_clear_accessor = "_clear_$accessor";
        $self->$_clear_accessor;
    };
    quote_sub "main::clear_$accessor", $cref,
      { '$accessor' => \$accessor, '$class' => \$accessor2class{$accessor} };
}

=head1 ATTRIBUTES

Fixtures are not installed in the database until the attribute is called. This is achieved by all accessors being lazy and so builders exist for each accessor to install the fixtures on demand.

=head2 jobs

=cut

sub _build_jobs {
    my $self = shift;
    my $rset = $self->schema->resultset('Job');

    $rset->create({
        name => 'dancer',
        description => 'Perl Dancer programmer'
    });

    return $rset;
}

=head1 METHODS

All attributes have a corresponding C<clear_$attribute> method which deletes all rows from the corresponding table and clears the accessor. Each also has a C<has_$attribute> accessor which returns true if the accessor has been set and false otherwise. All attributes are created lazy and are set on access. The full list of clear/has methods are:

=over

=item * clear_jobs

=item * has_jobs

=back

=head2 clear_all_fixtures

This additional method calls all of the clear_$accessor methods.

=cut

sub clear_all_fixtures {
    my $self = shift;
    foreach my $accessor (@accessors) {
        my $clear_accessor = "clear_$accessor";
        $self->$clear_accessor;
    }
}

=head2 load_all_fixtures

Loads all fixtures.

=cut

sub load_all_fixtures {
    my $self = shift;
    # do this in reverse orser
    my @a = @accessors;
    while ( scalar @a > 0 ) {
        my $accessor = pop @a;
        $self->$accessor;
    }
}

1;
