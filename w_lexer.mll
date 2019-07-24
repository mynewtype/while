{
  open W_parser
  exception Eof
}
let blank = [' ''\t']
let newline = ['\n']
let digit = ['0'-'9']+
let alpha = ['A'-'Z''a'-'z']
let alphanumeric = ['A'-'Z''a'-'z''0'-'9''_']
rule token =  parse
 | blank             {token lexbuf} (* skip *)
 | newline           { token lexbuf } (* End LINE *)
 | digit + as x      { INT(int_of_string x) }
 | "+"               { PLUS }
 | "-"               { MINUS }
 | "/"               { DIV }
 | ";"               { SEMICOL }
 | ":"               { COL }
 | eof               { EOF }
 | "="               { ASS }
 | "("               { L_PAREN }
 | ")"               { R_PAREN }
 | "*"               { AST }
 | "&"               { AMP }
 | "while"           { WHILE }
 | "end"             { END }
 | "print"           { PRINT }
 | alpha['A'-'Z''a'-'z''0'-'9''_']* as b  { VAR(b) }

