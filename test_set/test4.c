x = 1;
y = 2;
z = 0;
while ( x + 3 ) :
  x = ( x - 1 );
  z = ( z + x ) ;
  print x
end ;

print x ;

while z :
  z = ( z - 1 );
  print z
end ;

sum = ( x * ( y + z ) );
print sum