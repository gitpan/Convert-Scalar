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
        SvGETMAGIC (scalar);
        RETVAL = !!SvUTF8 (scalar);
        if (items > 1)
          {
            if (SvREADONLY (scalar))
              croak ("Convert::Scalar::utf8 called on read only scalar");
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
        PPCODE:
        if (SvREADONLY (scalar))
          croak ("Convert::Scalar::utf8_on called on read only scalar");

        SvGETMAGIC (scalar);
        SvUTF8_on (scalar);
        if (GIMME_V != G_VOID)
          XPUSHs (sv_2mortal (SvREFCNT_inc (scalar)));

void
utf8_off(scalar)
	SV *	scalar
        PROTOTYPE: $
        PPCODE:
        if (SvREADONLY (scalar))
          croak ("Convert::Scalar::utf8_off called on read only scalar");

        SvGETMAGIC (scalar);
        SvUTF8_off (scalar);
        if (GIMME_V != G_VOID)
          XPUSHs (sv_2mortal (SvREFCNT_inc (scalar)));

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
	PPCODE:
        if (SvREADONLY (scalar))
          croak ("Convert::Scalar::utf8_upgrade called on read only scalar");

        sv_utf8_upgrade(scalar);
        if (GIMME_V != G_VOID)
          XPUSHs (sv_2mortal (SvREFCNT_inc (scalar)));

bool
utf8_downgrade(scalar, fail_ok = 0)
	SV *	scalar
	bool	fail_ok
        PROTOTYPE: $;$
	CODE:
        if (SvREADONLY (scalar))
          croak ("Convert::Scalar::utf8_downgrade called on read only scalar");

        RETVAL = sv_utf8_downgrade (scalar, fail_ok);
	OUTPUT:
	RETVAL

void
utf8_encode(scalar)
	SV *	scalar
        PROTOTYPE: $
	PPCODE:
        if (SvREADONLY (scalar))
          croak ("Convert::Scalar::utf8_encode called on read only scalar");

        sv_utf8_encode (scalar);
        if (GIMME_V != G_VOID)
          XPUSHs (sv_2mortal (SvREFCNT_inc (scalar)));

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
        PPCODE:
        sv_grow (scalar, newlen);
        if (GIMME_V != G_VOID)
          XPUSHs (sv_2mortal (SvREFCNT_inc (scalar)));

int
refcnt(scalar,newrefcnt=0)
	SV *	scalar
        int	newrefcnt
        PROTOTYPE: $;$
        ALIAS:
          refcnt_rv = 1
        CODE:
        if (ix)
          {
            if (!SvROK (scalar)) croak ("refcnt_rv requires a reference as it's first argument");
            scalar = SvRV (scalar);
          }
        RETVAL = SvREFCNT (scalar);
        if (items > 1)
          SvREFCNT (scalar) = newrefcnt;
	OUTPUT:
        RETVAL

void
refcnt_inc(scalar)
	SV *	scalar
        ALIAS:
          refcnt_inc_rv = 1
        PROTOTYPE: $
        CODE:
        if (ix)
          {
            if (!SvROK (scalar)) croak ("refcnt_inc_rv requires a reference as it's first argument");
            scalar = SvRV (scalar);
          }
        SvREFCNT_inc (scalar);

void
refcnt_dec(scalar)
	SV *	scalar
        ALIAS:
          refcnt_dec_rv = 1
        PROTOTYPE: $
        CODE:
        if (ix)
          {
            if (!SvROK (scalar)) croak ("refcnt_dec_rv requires a reference as it's first argument");
            scalar = SvRV (scalar);
          }
        SvREFCNT_dec (scalar);
