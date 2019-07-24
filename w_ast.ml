type var = string

type num = int

type lhs =
  | Lhs of var
  | Pointer of lhs

type bop =
  | Plus
  | Minus

type expr =
  | ExprNum of num
  | ExprBop of bop * expr * expr
  | ExprLhs of lhs
  | ExprAddr of lhs

and stmt =
  | Assign of lhs * expr
  | While of expr * stmt
  | Print of expr
  | Seq of stmt list

type prog =
  | Prog of stmt
  
let pp ast =
  ()