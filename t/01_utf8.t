BEGIN { $| = 1; print "1..9\n"; }

use Convert::Scalar ':utf8';

no bytes;

$y = "\xff\x90\x44";

utf8_encode $y;

print length($y)==5 ? "" : "not ", "ok 1\n";
print utf8_length($y)==3 ? "" : "not ", "ok 2\n";

utf8_upgrade $y;
print utf8_length($y)==5 ? "" : "not ", "ok 3\n";
print length($y)==5 ? "" : "not ", "ok 4\n";

print utf8_downgrade($y) ? "" : "not ", "ok 5\n";
print utf8_length($y)==3 ? "" : "not ", "ok 6\n";
print length($y)==5 ? "" : "not ", "ok 7\n";

$y = "\x{257}";
print !utf8_downgrade($y, 1) ? "" : "not ", "ok 8\n";
print !eval {
   utf8_downgrade($y, 0);
   1;
} ? "" : "not ", "ok 9\n";

