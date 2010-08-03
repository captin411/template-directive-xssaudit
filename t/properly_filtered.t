use Test::More;

use Template::Directive::XSSAudit;
use Template;

my $TT2 = Template->new({
    FACTORY => 'Template::Directive::XSSAudit'
});
my $LATEST_RESPONSE;

Template::Directive::XSSAudit->good_filters([ 'html', 'uri' ]);
Template::Directive::XSSAudit->on_error( sub {
    $LATEST_RESPONSE = [ @_ ];
});

my @tests = (
    sub {
        my $t = "one variable - properly escaped - pipe filter";

        my $input = "[% user.email | html %]";
        undef $LATEST_RESPONSE;

        $TT2->process(\$input,{},\my $out) || die $TT2->error();

        is( $LATEST_RESPONSE, undef, $t );
    },
    sub {
        my $t = "one variable - properly escaped - block filter";

        my $input = "[% FILTER html %][% user.email %][% END %]";
        undef $LATEST_RESPONSE;

        $TT2->process(\$input,{},\my $out) || die $TT2->error();

        is( $LATEST_RESPONSE, undef, $t );
    },
    sub {
        my $t = "one variable - properly escaped - filter inline";

        my $input = "[% user.email FILTER html %]";
        undef $LATEST_RESPONSE;

        $TT2->process(\$input,{},\my $out) || die $TT2->error();

        is( $LATEST_RESPONSE, undef, $t );
    }

);

plan tests => scalar @tests;

$_->() for @tests;
