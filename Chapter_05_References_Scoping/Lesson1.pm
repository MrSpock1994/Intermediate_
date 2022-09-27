# References and Scoping

# We can copy and pass around references like any other scalar. At any given time, Perl
# knows the number of references to a particular data item. Perl can also create references
# to anonymous data structures that do not have explicit names and create references
# automatically as needed to fulfill certain kinds of operations. We’ll show you how to
# copy references and how it affects scoping and memory usage

# More than One Reference to Data
# Chapter 4 explored how to take a reference to an array @skipper and place it into a new
# scalar variable:
my @skipper = qw(blue_shirt hat jacket preserver sunscreen);
my $ref_to_skipper = \@skipper;
# We can then copy the reference or take additional references, and they’ll all refer to the
# same thing and are interchangeable:
my $second_ref_to_skipper = $reference_to_skipper;
my $third_ref_to_skipper = \@skipper;
# At this point, we have four different ways to access the data contained in @skipper:
@skipper
@$ref_to_skipper
@$second_ref_to_skipper
@$third_ref_to_skipper

# sub check_provisions_list(\@skipper)
# When this subroutine executes, Perl creates a fifth reference to the data and copies it
# into @_ for the subroutine. The subroutine is free to create additional copies of that
# reference, which Perl detects as needed. Typically, when the subroutine returns, Perl
# discards all such references automatically, and we’re back to four references again.
# We can kill off each reference by using the variable for something other than a reference
# to the value of @skipper. For example, we can assign undef to the variable:
$ref_to_skipper = undef;