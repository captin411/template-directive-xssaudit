#!perl
use Module::Build;

# See perldoc Module::Build for details of how this works

Module::Build->new(
    module_name        => 'Template::Directive::XSSAudit',
    license            => 'perl',
    dist_abstract      => 'TT2 output filtering lint testing',
    dist_author        => 'David Bartle <dbartle@mediatemple.net>',
    create_readme      => 1,
    create_makefile_pl => 'traditional',
    requires           => {
        'Template::Directive' => 0,
        'Template'            => 0,
        'Carp'                => 0,
    },
    build_requires => {
        'List::Util'          => 0,
        'Test::More'          => 0,
        'Template'            => 0,
    },
)->create_build_script;

