#!/usr/local/bin/perl -w

require Maker::Package;
require Maker::Rules;

{
    my $pk = new Maker::Package(top=>'TestOutput');
    $pk->pm_2version('Output.pm');
    $pk->default_targets('output');

    my $inst = {
	lib => [ 'Test/', 'Test/Output.html', 'Test/Output.pm' ],
    };

    my $r = Maker::Rules->new($pk, 'perl-module');
    $pk->a(new Maker::Seq($r->blib($inst),
			  $r->pod2html('Output.pm'),
			  $r->populate_blib($inst),
			  new Maker::Unit('output', sub {}),
			  ),
	   $r->install($inst),
	   $r->uninstall($inst),
	   new Maker::Unit('_test', sub {}),
	   );

    $pk->load_argv_flags;
    $pk->top_go(@ARGV);
}

