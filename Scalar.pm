=head1 NAME

Convert::Scalar - convert between different representations of perl scalars

=head1 SYNOPSIS

 use Convert::Scalar;

=head1 DESCRIPTION

This module exports various internal perl methods that change the internal
representation or state of a perl scalar. All of these work in-place, that
is, they modify their scalar argument. No functions are exported by default.

The following export tags exist:

 :utf8   all functions with utf8 in their name
 :taint  all functions with taint in their name
 :refcnt all functions with refcnt in their name

=over 4

=cut

package Convert::Scalar;

BEGIN {
   $VERSION = 0.09;
   @ISA = qw(Exporter);
   @EXPORT_OK = qw(weaken unmagic grow);
   %EXPORT_TAGS = (
      taint  => [qw(taint untaint tainted)],
      utf8   => [qw(utf8 utf8_on utf8_off utf8_valid utf8_upgrade utf8_downgrade utf8_encode utf8_decode utf8_length)],
      refcnt => [qw(refcnt refcnt_inc refcnt_dec refcnt_rv refcnt_inc_rv refcnt_dec_rv)],
   );

   require Exporter;
   Exporter::export_ok_tags(keys %EXPORT_TAGS);

   require XSLoader;
   XSLoader::load Convert::Scalar, $VERSION;
}

=item utf8 scalar[, mode]

Returns true when the given scalar is marked as utf8, false otherwise. If
the optional mode argument is given, also forces the interpretation of the
string to utf8 (mode true) or plain bytes (mode false). The actual (byte-)
content is not changed. The return value always reflects the state before
any modification is done.

This function is useful when you "import" utf8-data into perl, or when
some external function (e.g. storing/retrieving from a database) removes
the utf8-flag.

=item utf8_on scalar

Similar to C<utf8 scalar, 1>, but additionally returns the scalar (the
argument is still modified in-place).

=item utf8_off scalar

Similar to C<utf8 scalar, 0>, but additionally returns the scalar (the
argument is still modified in-place).

=item utf8_valid scalar [Perl 5.7]

Returns true if the bytes inside the scalar form a valid utf8 string,
false otherwise (the check is independent of the actual encoding perl
thinks the string is in).

=item utf8_upgrade scalar

Convert the string content of the scalar in-place to its UTF8-encoded form
(and also returns it).

=item utf8_downgrade scalar[, fail_ok=0]

Attempt to convert the string content of the scalar from UTF8-encoded to
ISO-8859-1. This may not be possible if the string contains characters
that cannot be represented in a single byte; if this is the case, it
leaves the scalar unchanged and either returns false or, if C<fail_ok> is
not true (the default), croaks.

=item utf8_encode scalar

Convert the string value of the scalar to UTF8-encoded, but then turn off
the C<SvUTF8> flag so that it looks like bytes to perl again. (Might be
removed in future versions).

=item utf8_length scalar

Returns the number of characters in the string, counting wide UTF8
characters as a single character, independent of wether the scalar is
marked as containing bytes or mulitbyte characters.

=item unmagic scalar

Removes magic from the scalar.

=item weaken scalar

Weaken a reference. (See also L<WeakRef>).

=item taint scalar

Taint the scalar.

=item tainted scalar

returns true when the scalar is tainted, false otherwise.

=item untaint scalar, type

Remove the specified magic from the scalar
(DANGEROUS!), L<perlguts>. L<Untaint>, for a similar but different
interface.

=item grow scalar, newlen

Sets the memory area used for the scalar to the given length, if the
current length is less than the new value. This does not affect the
contents of the scalar, but is only useful to "pre-allocate" memory space
if you know the scalar will grow. The return value is the modified scalar
(the scalar is modified in-place).

=item refcnt scalar[, newrefcnt]

Returns the current reference count of the given scalar and optionally sets it to
the given reference count.

=item refcnt_inc scalar

Increments the reference count of the given scalar inplace.

=item refcnt_dec scalar

Decrements the reference count of the given scalar inplace. Use C<weaken>
instead if you understand what this function is fore. Better yet: don't
use this module in this case.

=item refcnt_rv scalar[, newrefcnt]

Works like C<refcnt>, but dereferences the given reference first. Remember
that taking a reference of some object increases it's reference count, so
the reference count used by the C<*_rv>-funtions tend to be one higher.

=item refcnt_inc_rv scalar

Works like C<refcnt_inc>, but dereferences the given reference first.

=item refcnt_dec_rv scalar

Works like C<refcnt_dec>, but dereferences the given reference first.

=cut

1;

=back

=head2 CANDIDATES FOR FUTURE RELEASES

The following API functions (L<perlapi>) are considered for future
inclusion in this module If you want them, write me.

 sv_upgrade
 sv_pvn_force
 sv_pvutf8n_force
 the sv2xx family

=head1 AUTHOR

 Marc Lehmann <pcg@goof.com>
 http://www.goof.com/pcg/marc/

=cut

