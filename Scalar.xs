#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

MODULE = Convert::Scalar		PACKAGE = Convert::Scalar

void
utf8_upgrade(scalar)
	SV *	scalar
        PROTOTYPE: $
	CODE:
        sv_utf8_upgrade(scalar);

bool
utf8_downgrade(scalar, fail_ok = 0)
	SV *	scalar
	bool	fail_ok
        PROTOTYPE: $;$
	CODE:
        RETVAL = sv_utf8_downgrade (scalar, fail_ok);
	OUTPUT:
	RETVAL

void
utf8_encode(scalar)
	SV *	scalar
        PROTOTYPE: $
	CODE:
        sv_utf8_encode (scalar);

UV
utf8_length(scalar)
	SV *	scalar
        PROTOTYPE: $
	CODE:
        RETVAL = (UV) sv_len_utf8 (scalar);
	OUTPUT:
	RETVAL

void
unmagic(scalar, type)
	SV *	scalar
        char	type
        PROTOTYPE: $
	CODE:
        sv_unmagic (scalar, type);

void
weaken(scalar)
	SV *	scalar
        PROTOTYPE: $
	CODE:
        sv_rvweaken (scalar);

void
taint(scalar)
	SV *	scalar
        PROTOTYPE: $
	CODE:
        sv_taint (scalar);

void
untaint(scalar)
	SV *	scalar
        PROTOTYPE: $
	CODE:
        sv_untaint (scalar);


