use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Test::Differences::Color',
    license             => 'perl',
    dist_author         => 'Alec Chen <alec@cpan.org>',
    dist_version_from   => 'lib/Test/Differences/Color.pm',
    build_requires => {
        'Test::More'        => 0.8,
        'Sub::Override'     => 0.08,
        'Term::ANSIColor'   => 1.12,
        'Test::Differences' => 0.4801,
        'Exporter'          => 5.63,
        'version'           => 0.76,
    },
    add_to_cleanup      => [ 'Test-Differences-Color-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
