#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#if PERL_VERSION < 7
# define is_utf8_string(s,l) (croak ("utf8_valid requires perl 5.7 or higher"), 0)
#endif

MODULE = Convert::Scalar		PACKAGE = Convert::Scalar

int
utf8(scalar,mode=0)
	SV *	scalar
        SV *	mode
        PROTOTYPE: $;$
        CODE:
        RETVAL = !!SvUTF8 (scalar);
        if (items > 1)
          {
            if (SvTRUE (mode))
              SvUTF8_on (scalar);
            else
              SvUTF8_off (scalar);
          }
	OUTPUT:
        RETVAL

void
utf8_on(scalar)
	SV *	scalar
        PROTOTYPE: $
        CODE:
        SvUTF8_on (scalar);

void
utf8_off(scalar)
	SV *	scalar
        PROTOTYPE: $
        CODE:
        SvUTF8_off (scalar);

int
utf8_valid(scalar)
	SV *	scalar
        PROTOTYPE: $
        CODE:
        STRLEN len;
        char *str = SvPV (scalar, len);
        RETVAL = !!is_utf8_string (str, len);
	OUTPUT:
        RETVAL

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
        SvTAINTED_on (scalar);

int
tainted(scalar)
	SV *	scalar
        PROTOTYPE: $
        CODE:
        RETVAL = SvTAINTED (scalar);
	OUTPUT:
        RETVAL

void
untaint(scalar)
	SV *	scalar
        PROTOTYPE: $
	CODE:
        SvTAINTED_off (scalar);

void
grow(scalar,newlen)
	SV *	scalar
        U32	newlen
        PROTOTYPE: $$
        CODE:
        sv_grow (scalar, newlen);

