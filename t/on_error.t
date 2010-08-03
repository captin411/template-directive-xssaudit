use Test::More;

use Template::Directive::XSSAudit;

my @tests = (
    sub {
        my $t = "Default event handler is installed";

        is(
            $Template::Directive::XSSAudit::DEFAULT_ERROR_HANDLER,
            Template::Directive::XSSAudit->on_error(),
            $t
        );

    },
    sub {
        my $t = "Setting event handler - coderef";

        my $code = sub { 1; };
        Template::Directive::XSSAudit->on_error( $code );
        is( $code, Template::Directive::XSSAudit->on_error, $t );

    },
    sub {
        my $t = "Setting event handler - set to string (should die)";

        eval {
            Template::Directive::XSSAudit->on_error( "asdf" );
        };
        my $err = $@;
        ok( $err, $t );

    },
    sub {
        my $t = "Event handler stays the same when reading it";

        my $code1 = sub { 1; };
        Template::Directive::XSSAudit->on_error( $code1 );

        my $code2 = Template::Directive::XSSAudit->on_error();
        is( $code1, $code2, $t );

    },
    sub {
        my $t = "Get and set operation at the same time";

        my $code1 = sub { 9999; };
        my $code2 = Template::Directive::XSSAudit->on_error( $code1 );
        is( $code1, $code2, $t );

    },

);

plan tests => scalar @tests;

$_->() for @tests;
