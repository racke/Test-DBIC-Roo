use strict;
use warnings;
use ExtUtils::MakeMaker;


WriteMakefile(
    NAME                => 'Test::DBIC::Roo',
    AUTHOR              => q{Stefan Hornburg (Racke) <racke@linuxia.de>},
    VERSION_FROM        => 'lib/Test/DBIC/Roo.pm',
    ABSTRACT_FROM       => 'lib/Test/DBIC/Roo.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.47
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    EXE_FILES           => [],
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
        'DBIx::Class'         => 0,
    },
    PREREQ_PM => do {
        eval { require DBIx::Class::Optional::Dependencies };
        my $dbic_deps =
          $@
          ? { 'SQL::Translator' => 0 }
          : DBIx::Class::Optional::Dependencies->req_list_for('deploy');

        my $ret = +{
            'Class::Method::Modifiers'             => 0,
            'DBIx::Class'                          => 0,
            'Sub::Quote'                           => 1.004006,

            # sample schema for testing
            'Test::DBIx::Class::Example::Schema' => 0,

            'Test::Roo'             => 1.003,
            %$dbic_deps,
        };
    },
    BUILD_REQUIRES => {
                       'Data::Dumper::Concise' => 0,
                       'File::Temp' => 0,
                       'Test::MockTime' => 0,
                       'Test::More' => 0,
                       'Test::Most' => 0.33,
                       'Test::Warnings' => 0,
                       'DBD::SQLite' => 1.38_01,
                      },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-DBIC-Roo' },
    META_MERGE        => {
        resources => {
            repository  => 'https://github.com/racke/Test-DBIC-Roo.git',
            bugtracker => 'https://github.com/racke/Test-DBIC-Roo/issues',
            IRC => 'irc://irc.freenode.net/#interchange',
        },
    },
);
