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
# @skipper
# @$ref_to_skipper
# @$second_ref_to_skipper
# @$third_ref_to_skipper

# sub check_provisions_list(\@skipper)
# When this subroutine executes, Perl creates a fifth reference to the data and copies it
# into @_ for the subroutine. The subroutine is free to create additional copies of that
# reference, which Perl detects as needed. Typically, when the subroutine returns, Perl
# discards all such references automatically, and we’re back to four references again.
# We can kill off each reference by using the variable for something other than a reference
# to the value of @skipper. For example, we can assign undef to the variable:
$ref_to_skipper = undef;


# What If That Was the Name?
# Typically, all references to a variable are gone before the variable itself. But what if one
# of the references outlives the variable name? For example, consider this code:

my $ref;
{
    my @skipper = qw(blue_shirt hat jacket preserver sunscreen);
    $ref = \@skipper;
    print "$ref->[2]\n";
}

 print "$ref->[2]\n";

# We can reduce the namespace clutter by narrowing down the scope of the various array
# names. Rather than declaring them within the scope of the subroutine, we can create
# a temporary block:

my $skipper_with_name;
{
    my @skipper = qw(blue_shirt hat jacket preserver sunscreen);
    @skipper_with_name = ('The Skipper', \@skipper);
}

print "@skipper_with_name[1]";

# At this point, the second element of @skipper_with_name is a reference to the array
# formerly known as @skipper. However, that name is no longer relevant.
# This is a lot of typing to say “the second element should be a reference to an array
# containing these elements.” We can create such a value directly using the anonymous
# array constructor, which is yet another use for square brackets:
# my $ref_to_skipper_provisions =
# [ qw(blue_shirt hat jacket preserver sunscreen) ];
# The square brackets take the value within (evaluated in list context); establish a new,
# anonymous array initialized to those values; and (here’s the important part) return a
# reference to that array. It’s as if we had said:
# my $ref_to_skipper_provisions;
# {
# my @temporary_name =
# ( qw(blue_shirt hat jacket preserver sunscreen) );
# $ref_to_skipper_provisions = \@temporary_name;
# }
# We don’t need to come up with a temporary name, and we don’t need the extra noise
# of the temporary block. The result of a square-bracketed anonymous array constructor
# is an array reference, which fits wherever a scalar variable fits.

# So, in summary, if we have this syntax:
# my $fruits;
# {
# my @secret_variable = ('pineapple', 'papaya', 'mango');
# $fruits = \@secret_variable;
# }
# we can replace it with:
# my $fruits = ['pineapple', 'papaya', 'mango'];