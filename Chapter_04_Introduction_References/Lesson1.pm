# Introduction to References

# A Perl scalar variable holds a single value. An array holds an ordered list of scalars. A
# hash holds an unordered collection of scalars as values, keyed by strings. Although a
# scalar can be an arbitrary string, which lets us encode complex data in an array or hash,
# none of the three data types are well suited to complex data interrelationships. This is
# a job for the reference. We look at the importance of references by starting with an
# example.


# Doing the Same Task on Many Arrays
# Before the Minnow can leave on an excursion (for example, a three-hour tour), we
# should check every passenger and crew member to ensure they have all the required
# trip items in their possession. For maritime safety, every person aboard the Minnow
# needs to have a life preserver, some sunscreen, a water bottle, and a rain jacket. We
# can write a bit of code to check for the Skipper’s supplies:
my @required = qw(preserver sunscreen water_bottle jacket);
my %skipper = map { $_, 1 }
qw(blue_shirt hat jacket preserver sunscreen);
foreach my $item (@required) {
    unless ( $skipper{$item} ) { # not found in list?
        print "Skipper is missing $item.\n";
    }
}
# Notice that we created a hash from the list of Skipper’s items. That’s a common and
# useful operation. Since we want to check if a particular item is in Skipper’s list, the
# easiest way is to make all the items keys of a hash then check the hash with exists.
# Here, we’ve given every key a true value, so we don’t use exists. Instead of typing out
# the hash completely, we use the map to create it from the list of items.

# If we want to check on Gilligan and the Professor, we might write the following code:
my %gilligan = map { $_, 1 } qw(red_shirt hat lucky_socks water_bottle);
print %gilligan;
foreach my $item (@required) {
    unless ( $gilligan{$item} ) { # not found in list?
        print "Gilligan is missing $item.\n";
    }   
}

my %professor = map { $_, 1 } qw(sunscreen water_bottle slide_rule batteries radio);
for my $item (@required) {
    unless ( $professor{$item} ) { # not found in list?
        print "The Professor is missing $item.\n";
    }
}

# When we program like this, we start to realize a lot of repeated code here and think
# that we should refactor that into a common subroutine that we can reuse:
sub check_required_items {
    my $who = shift;
    my %whos_items = map { $_, 1 } @_; # the rest are the person's items
    my @required = qw(preserver sunscreen water_bottle jacket);

    for my $item (@required) {
        unless ( $whos_items{$item} ) { # not found in list?
            print "$who is missing $item.\n";
        }
    }
}
my @gilligan = qw(red_shirt hat lucky_socks water_bottle);
check_required_items('gilligan', @gilligan);


# Checking Reference Types
# Once we start using references and passing them around, we have to ensure that we
# know which sort of reference we have. If we try to use the reference as a type that it is
# not, our program will blow up:
show_hash( \@array );
sub show_hash {
my $hash_ref = shift;
}
foreach my $key ( %$hash_ref ) {
...
}
# The show_hash subroutine expects a hash and trusts that we pass it one. However, since
# we passed it an array reference, our program blows up:
# Not a HASH reference at line ...
# If we want to be careful, we should check the argument to show_hash to ensure that it’s
# actually a hash reference. There are a couple ways that we could do this. The easy way
# uses ref, which returns the reference type. We compare the return value from ref to
# what we expected:

use Carp qw(croak);
sub show_hash {
    my $hash_ref = shift;
    my $ref_type = ref $hash_ref;
    croak "I expected a hash reference!"
    unless $ref_type eq 'HASH';
}
foreach my $key ( %$hash_ref ) {
...
}