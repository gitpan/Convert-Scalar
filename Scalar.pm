=head1 NAME

Convert::Scalar - convert between different representations of perl scalars

=head1 SYNOPSIS

 use Convert::Scalar;

=head1 DESCRIPTION

This module exports various internal perl methods that change the internal
representation or state of a perl scalar. All of these work in-place, that
is, they modify their scalar argument. No functions are exported by default.

The following export tags exist:

 :utf8   all functions with utf8 in their names
 :taint  all functions with taint in their names

=over 4

=cut

package Convert::Scalar;

BEGIN {
   $VERSION = 0.02;
   @ISA = qw(Exporter);
   @EXPORT_OK = qw(weaken unmagic);
   %EXPORT_TAGS = (
      taint => [qw(taint untaint)],
      utf8  => [qw(utf8_upgrade utf8_downgrade utf8_encode utf8_decode utf8_length)],
   );

   require Exporter;
   Exporter::export_ok_tags(keys %EXPORT_TAGS);

   require XSLoader;
   XSLoader::load Convert::Scalar, $VERSION;
}

=item utf8_upgrade scalar

Convert the string content of the scalar to its UTF8-encoded form.

=item utf8_downgrade scalar[, fail_ok]

Attempt to convert the string content of the scalar from UTF8-encoded
to bytes..  This may not be possible if the string contains characters
that cannot be represented in a single byte; if this is the case, either
returns false or, if C<fail_ok> is not true (the default), croaks.

=item utf8_encode scalar

Convert the string value of the scalar to UTF8-encoded, but then turn off
the C<SvUTF8> flag so that it looks like bytes to perl again. (Might be
removed in future versions).

=item utf8_length scalar

Returns the number of characters in the string, counting wide UTF8 bytes
as a single character, idnependent of wether the scalar is marked as
containing bytes or mulitbyte characters.

=item unmagic scalar

Removes magic from the scalar.

=item weaken scalar

Weaken a reference. (See also the WeakRef module (L<WeakRef>).

=item taint scalar

Taint the scalar.

=item untaint scalar, type

Remove the specified magic from the scalar
(DANGEROUS!), L<perlguts>. Might be removed in future versions.

=cut

1;

=back

=head2 CANDIDATES FOR FUTURE RELEASES

The following API functions (L<perlapi>) are considered for future
inclusion in this module If you want them, write me.

 sv_grow
 sv_upgrade
 sv_pvn_force
 sv_pvutf8n_force
 the sv2xx family

=head1 BUGS

This module has not yet been extensively tested.

=head1 AUTHOR

 Marc Lehmann <pcg@goof.com>
 http://www.goof.com/pcg/marc/

=cut

