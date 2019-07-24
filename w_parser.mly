%{open W_ast %}
%token <string> VAR
%token <int> INT
%token PLUS MINUS DIV
%token EOF ASS COL SEMICOL AST AMP END COLON WHILE PRINT
%token L_PAREN R_PAREN
%start main
%type <W_ast.prog>  main
%%
main:

prog EOF     { $1 }
;

prog:
    | stmt { Prog($1) }
;

lhs:
    | VAR { Lhs($1) }
;

bop:
    | PLUS { Plus }
    | MINUS { Minus }
;

exp:
    | INT           { ExprNum($1) }
    | L_PAREN exp bop exp R_PAREN { ExprBop( $3 ,$2, $4 ) }
;

stmt:
    | PRINT exp { Print ($2) }
    | seqs { Seq($1)}
;

seqs:
    | stmt      { [$1] }
    | stmt SEMICOL seqs { $1::$3 }
;

