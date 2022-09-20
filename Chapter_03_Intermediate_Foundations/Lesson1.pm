# Intermediate Foundations


# Before we get started on the meat of the book, we want to introduce some intermediate-
# level Perl idioms that we use throughout the book. These are the things that typically
# set apart the beginning and intermediate Perl programmers. We’ll also introduce the
# first cast of characters that we’ll use in the examples throughout the book.
# List Operators
# A list is an ordered collection of scalars. Lists are the values themselves, and sometimes
# we store lists in arrays, the container that holds an ordered list. List operators do some-
# thing with multiple elements, and most don’t care if they use a literal list, the return
# values from a subroutine, or an array variable.
# We already know several list operators in Perl, but we may not have thought of them
# as working with lists. The most common list operator is print. We give it one or more
# arguments, and it puts them together for us:
print 'Two castaways are ', 'Gilligan', ' and ', 'Skipper', "\n";
# There are several other list operators that we already showed in Learning Perl. The
# sort operator puts its input list in order. In their theme song, the castaways don’t come
# in alphabetical order, but sort can fix that for us:
my @castaways = sort qw(Gilligan Skipper Ginger Professor Mary Ann);
# The reverse operator returns a list in the opposite order:
my @castaways = reverse qw(Gilligan Skipper Ginger Professor Mary Ann);
# We can even use these operators “in place” by having the same array on both the
# righthand and lefthand sides of the assignment. Perl figures out the righthand side first,
# knows the result, and then assigns that back to the original variable name:
my @castaways = qw(Gilligan Skipper Ginger Professor);
push @castaways, 'Mary Ann';
@castaways = reverse @castaways;

# List Filtering with grep
# The grep operator takes a “testing expression” and a list of values. It takes each item
# from the list in turn and places it into the $_ variable. It then evaluates the testing
# expression in scalar context. If the expression evaluates to a true value, grep passes
# $_ on to the output list:
# my @lunch_choices = grep is_edible($_), @gilligans_possessions ;
# In list context, the grep operator returns a list of all such selected items. In scalar con-
# text, grep returns the number of selected items:
# my @results = grep EXPR, @input_list;
# my $count = grep EXPR, @input_list;
# Here, EXPR stands in for any scalar expression that should refer to $_ (explicitly or
# implicitly). For example, to find all the numbers greater than 10, in our grep expression
# we check if $_ is greater than 10:

my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
my @bigger_than_10 = grep $_ > 10, @input_numbers;


If the testing expression is complex, we can hide it in a subroutine:
my @odd_digit_sum = grep digit_sum_is_odd($_), @input_numbers;
sub digit_sum_is_odd {
    my $input = shift;
    my @digits = split //, $input; # Assume no nondigit characters
    my $sum;
    $sum += $_ for @digits;
    return $sum % 2;
}


# Transforming Lists with map
# The map operator transforms one list into another. It has a syntax identical to the
# grep operator’s and shares a lot of the same operational steps. For example, it tem-
# porarily places items from a list into $_ one at a time, and the syntax allows both the
# expression block forms.
# Our map expression is for transformation instead of testing. The map operator evaluates
# our expression in list context, not scalar context like grep. Each evaluation of the ex-
# pression gives a portion of the list that becomes the final list. The end result is the
# concatenation of all individual results. In scalar context, map returns the number of
# elements returned in list context. But map should rarely, if ever, be used in anything but
# list context.
# We start with a simple example:


my @input_numbers = (1, 2, 4, 8, 16, 32, 64);
my @result = map $_ + 100, @input_numbers;
# For each of the seven items map places into $_, we get a single item to add to the output
# list: the number that is 100 greater than the input number, so the value of @result is
# 101, 102, 104, 108, 116, 132, and 164.
# But we’re not limited to having only one output per input. We can see what happens
# when each input produces two output items:
my @result = map { $_, 3 * $_ } @input_numbers;
# Now there are two items for each input item: 1, 3, 2, 6, 4, 12, 8, 24, 16, 48, 32, 96, 64,
# and 192. We can store those pairs in a hash, if we need a hash showing what number
# is three times a small power of two:


# The do Block
# The do block is one powerful but overlooked feature of Perl. It provides a way to group
# statements as a single expression that we can use in another expression. It’s almost
# like an inline subroutine. As with subroutines, the result of do is the last evaluated
# expression.
# First, consider a bit of code to assign one of three possible values to a variable. We
# declare $bowler as a lexical variable, and we use an if−elsif−else structure to choose
# which value to assign. We end up typing the variable name four times to get a single
# assignment:
my $bowler;
if( ...some condition... ) {
    $bowler = 'Mary Ann';
}
elsif( ... some condition ... ) {
    $bowler = 'Ginger';
}
else {
    $bowler = 'The Professor';
}
# However, with do, we only have to use the variable name once. We can assign to it at
# the same time that we declare it because we can combine everything else in the do as if
# it were a single expression:
my $bowler = do {
    if( ... some condition ... ) { 'Mary Ann' }
    elsif( ... some condition ... ) { 'Ginger' }
    else { 'The Professor' }
};