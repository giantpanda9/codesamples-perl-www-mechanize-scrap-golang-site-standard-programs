#!/usr/bin/perl -w
use strict;
use warnings;
use WWW::Mechanize::Query; # Simply wanted to try how this works
my $mech = WWW::Mechanize::Query->new();
$mech->get( 'http://www.imdb.com/' );
$mech->input( 'select[name="s"]', 'ep' );     #select "TV" from drop-down list
$mech->submit();
 
print $mech->content;
 
#TODO: Right now it fills out the first matching field but should be restricted to selected form.
