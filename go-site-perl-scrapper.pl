#!/usr/bin/perl -w
use strict;
use warnings;
BEGIN { unshift @INC, '.'; } # To use local folder as source for modules until the WWW::Mechanize::Query would be fixed - shallapply my fixes
use WWW::Mechanize::Query26; # Simply wanted to try how this works
use WWW::Mechanize;
use Mojo::DOM; 
use Getopt::Long;

sub getItems {
	my $url = "https://play.golang.org/";
	my $mech = WWW::Mechanize::Query26->new();
	$mech->get($url);

	my @returned;
	my $selectProgramXPath = '.js-playgroundToysEl > option';
	$mech->find( $selectProgramXPath )-> each ( sub { 
		my $item = shift;
		my $value = $item->{'value'};
		my $name = $value;
		$name =~ s/\.txt//; 
		my $displayName = $item->text; 
		push (@returned, {
			"name" => $name, 
			"value" => $value,
			"displayName" => $displayName		
			} );
	} );
	return @returned;
}

sub executeItem {
	my $program = shift;
	$program .= ".txt";
	print $program . "\n";

	my $url = "https://play.golang.org/";
	my $mech = WWW::Mechanize::Query26->new();
	$mech->get($url);
		 #print $mech->content();
	 print "\n";

	 $mech->input( 'select[class="js-playgroundToysEl"]', 'test.txt' ); 
	 $mech->post($url, Content => $mech->content());
	 		 print $mech->content();
	 print "\n";
	my $returned;

}

my $help;
my $show;
my $execute = "hello";
GetOptions ("help" => \$help,
			"show"   => \$show,
			"execute=s"  => \$execute
			) or die("Error in command line arguments\n");
if ($help) {
	print "Help placeholder\n";
	exit;
} elsif ($show) {
	my @list = getItems();
	if (scalar(@list) > 0) {
		print "Programs that https://play.golang.org/ site has installed:\n";
		foreach (@list) {
			print "+-----------------------------------------------------+\n";
			print "  Program display name: " . $_->{"displayName"} ."\n";
			print "  Program execution name: " . $_->{"name"} ."\n";
			print "  Program source code file name: " . $_->{"value"} ."\n";			
		}
		print "+-----------------------------------------------------+\n";
	} else {
		print "No programs found on https://play.golang.org/ site - go compare your code and site's content:";
	} 
	exit;
} elsif ($execute) {
	print $execute . "\n";
	executeItem($execute);
	print "\n";
	exit;
}




