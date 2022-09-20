# Using Modules

# The killer feature of Perl is the Comprehensive Perl Archive Network, which we just
# call CPAN. Perl already comes with many modules, but there are many more third-
# party modules available from CPAN. If we have a problem to solve or a task to complete
# with Perl, there’s probably a module on CPAN that will help us. An effective Perl pro-
# grammer is the one who uses CPAN wisely.

# Functional Interfaces
# To load a module, we use the Perl built-in use. We’re not going to go into all of the
# details here, but we’ll get to those in Chapter 11 and Chapter 17. At the moment, we
# just want to use the module. We start with File::Basename, that same module from the
# core distribution. To load it into our script, we say:
#     use File::Basename;
# When we do this, File::Basename introduces three subroutines, fileparse, basename,
# and dirname, into our script (using the stuff we show in Chapter 17). From this point
# forward, we can use the subroutines just as if we had defined them directly in the same
# file:
#     my $basename = basename( $some_full_path );
#     my $dirname = dirname( $some_full_path );

# The File::Basename module knows what sort of system it’s on, and thus its functions
# figure out how to correctly parse the strings for the different delimiters we might
# encounter.

# However, suppose we already had a dirname subroutine? We’ve now overwritten it with
# the definition provided by File::Basename! If we had turned on warnings, we would
# have seen a message stating that, but otherwise, Perl really doesn’t care.


# Selecting What to Import
# Fortunately, we can tell the use operation to limit its actions by specifying a list of
# subroutine names following the module name, called the import list:
# use File::Basename ('fileparse', 'basename');
# Now the module gives us only those two subroutines and leaves our own dirname alone.
# But this is awkward to type, so more often we’ll see this written with the quotewords
# operator:
# use File::Basename qw( fileparse basename );
# Even if there’s only one item, we tend to write it with a qw( ) list for consistency and
# maintenance; often, we’ll go back to say “give me another one from here,” and it’s
# simpler if it’s already a qw( ) list.
# We’ve protected the local dirname routine, but what if we still want the functionality
# provided by File::Basename’s dirname? No problem. We just spell it out with its full
# package specification:
# my $dirname = File::Basename::dirname($some_path);
# The list of names following use doesn’t change which subroutines are defined in the
# module’s package (in this case, File::Basename). We can always use the full name re-
# gardless of the import list, as in:
# my $basename = File::Basename::basename($some_path);


# Unlike the File::Basename module, the File::Spec module has a primarily object-
# oriented interface. We load the module with use, as we did before:
# use File::Spec;
# However, since this module has an object-oriented interface, it doesn’t import any
# subroutines. Instead, the interface tells us to access the functionality of the module
# using its class methods. The catfile method joins a list of strings with the appropriate
# directory separator:
# my $filespec = File::Spec−>catfile( $homedir{gilligan},
# 'web_docs', 'photos', 'USS_Minnow.gif' );
# This calls the class method catfile of the File::Spec class, which builds a path ap-
# propriate for the local operating system and returns a single string.2 This is similar in
# syntax to the nearly two dozen other operations provided by File::Spec.
# The File::Spec module provides several other methods for dealing with file paths in a
# portable manner.


# Instead of using numbers as literals, Math::BigInt turns them into numbers:
# use Math::BigInt;
# my $value = Math::BigInt−>new(2); # start with 2
# $value−>bpow(1000);# take 2**1000
# print $value−>bstr, "\n";# print it out
# As before, this module imports nothing. Its entire interface uses class methods, such
# as new, against the class name to create instances, and then calls instance methods, such
# as bpow and bstr, against those instances.

# Installing Modules from CPAN
# Installing a simple module from CPAN can be straightforward. We can use the cpan
# program that comes with Perl. We tell it which modules to install. If we want to install
# the Perl::Critic module, which can review code automatically, we give cpan that
# module name:
# % cpan Perl::Critic
# The first time we run this, we might have to go through the configuration steps to
# initialize CPAN.pm, but after that it should get directly to work. The program downloads
# the module and starts to build it. If the module depends on other modules, cpan will
# automatically fetch and then build those as well.
# If we start cpan with no arguments, we start the