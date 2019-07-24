#load "w_ast.cmo";;
open W_ast;;


module type MEMORY = sig 
  type memory
  val blank : memory list
  val put : int -> int -> memory list -> memory list
  val get : int -> memory list -> int
  val remove : int -> memory list -> memory list
  val findEmpty : memory list -> int
end


module Memory :MEMORY = struct
  type memory = { index:int; value:int}

  let blank = []

  let findEmpty mem =
    let rec loop expect mem =
      match mem with
      | h::t -> if(expect==h.index) then loop (expect+1) t else expect
      | [] -> 0
    in 
    loop 1 (List.sort (fun a -> fun b -> (b.index)-(a.index)) mem)

  let put i v mem =
    {index=i;value=v}::mem

  let rec get i mem =
    match mem with
    | h::t ->
      if(i=h.index) then h.value
      else get i t
    | [] -> raise (Failure "Env Invalid Index Error !")

  let rec remove n mem= 
    let rec loop n mem1 mem2=
      match mem2 with
      | h::t -> if (h.index=n) 
          then  mem1@t
          else loop n (h::mem1) t
      | [] -> raise (Failure "Env Invalid Index Error !")
    in
    loop n [] mem

end
;;


module type ENVIRONMENT = sig 
  type environ
  val blank : environ list
  val put : string -> int -> environ list -> environ list
  val get : string -> environ list -> int
  val remove : string -> environ list -> environ list
end
;;


module Environment :ENVIRONMENT = struct
  type environ = { name:string; value:int}

  let blank = []

  let put n v env =
    let rec loop n v env1 env2=
      match env2 with
      | h::t -> if (h.name=n) 
          then  env1@({name=n;value=v}::t)
          else loop n v (h::env1) t
      | [] -> {name=n;value=v}::env1
    in
    loop n v [] env

  
	let rec get n env =
  	match env with
  	| h::t ->
  		if(n=h.name) then h.value
  		else get n t
  	| [] -> raise (Failure "Env Invalid name Error !")


  let rec remove n env= 
    let rec loop n env1 env2=
      match env2 with
      | h::t -> if (h.name=n) 
          then  env1@t
          else loop n (h::env1) t
      | [] -> raise (Failure "Env Invalid name Error !")
    in
    loop n [] env

end
;;

let save name value env mem =
  let index = Memory.findEmpty mem in
  (Environment.put name index env, Memory.put index value mem)

let get name env mem =
  Memory.get (Environment.get name env) mem

let m = Memory.blank;;;
let e = Environment.blank;;


let (e, m) = save "x" 1 e m ;;
let (e, m) = save "y" 2 e m ;;