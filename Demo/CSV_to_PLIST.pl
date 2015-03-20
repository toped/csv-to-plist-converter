#!/usr/bin/perl
#**********************************************************************************************************************************
   #file      CSV_to_PLIST.pl
   #author    Tope Daramola <https://github.com/toped>
   #brief     File converter from CSV to Plist

   # This is an example program intended to output a .plist file given a .csv file (Windows Comma Seperated)
#***********************************************************************************************************************************

my $iFile = "nba_players.csv"; #enter the name of the file to be converted including its extension
my $oFile = "nba_players.plist"; #choose and enter the name of the outfile including its extension

#***********************************************************************************************************************************

unlink $oFile; #remove the original plist 


open(INFO,"<$iFile ");  
open(XML,">>$oFile");

print XML '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
';

$count = 0;

while(<INFO>){

	chomp();

	($heading1, $heading2, $heading3, $heading4, $heading5, $heading6, $heading7, $heading8, $heading9, $heading10) = split(','); # add, remove, or change header namer if needed
	
	$heading1 = cleanCsvInput($heading1);
	$heading2 = cleanCsvInput($heading2);
	$heading3 = cleanCsvInput($heading3);
	$heading4 = cleanCsvInput($heading4);
	$heading5 = cleanCsvInput($heading5);
	$heading6 = cleanCsvInput($heading6);
	$heading7 = cleanCsvInput($heading7);
	$heading8 = cleanCsvInput($heading8);
	$heading9 = cleanCsvInput($heading9);
	$heading10 = cleanCsvInput($heading10);

 	
    #wait till second iteration to write to file.	
    #don't want to write to file yet because first line is garbage.
    if($count>0){

    #Note: This first key should be unique
    print XML '<key>'.$count.'</key>
    	<dict>
			<key>Heading1</key>
				<string>'.$heading1.'</string>
			<key>Heading2</key>
				<string>'.$heading2.'</string>
			<key>Heading3</key>
				<string>'.$heading3.'</string>
			<key>Heading4</key>
				<string>'.$heading4.'</string>
			<key>Heading5</key>
				<string>'.$heading5.'</string>
			<key>Heading6</key>
				<string>'.$heading6.'</string>
			<key>Heading7</key>
				<string>'.$heading7.'</string>
			<key>Heading8</key>
				<string>'.$heading8.'</string>
			<key>Heading9</key>
				<string>'.$heading9.'</string>
			<key>Heading10</key>
				<string>'.$heading10.'</string>
		</dict>
		';
     }	 
   
$count += 1;

}

print XML '</dict>
</plist>';

print "$iFile has been converted to a plist.\n";

sub cleanCsvInput {

	$str = $_[0];

	#remove leading and trailing spaces
	$str =~ s/^\s+//;
	$str =~ s/\s+$//;

	#remove XML entities (&, <, >)
	$str =~ s/&/&amp;/g;
	$str =~ s/</&lt;/g;
	$str =~ s/</&gt;/g;

	#encode the rest in utf8
	$str = encode("utf8", $str);

    return($str);
}

