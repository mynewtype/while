open W_ast
let _ =
  try
  let filename =  Sys.argv.(1) in 
    print_string filename; print_string " ==> \n";
    let chnl = open_in filename in
    let lexbuf = Lexing.from_channel chnl in
      let ast = W_parser.main W_lexer.token lexbuf in
      pp ast;
      (* (* (); *)
        (* let pp = Inter.pp_prog ast in
        print_string pp;print_newline();
        let _ = Inter.eval ast in *)
      let m = Inter.eval ast in
      Dot.print m; *)
       print_string "\t  done"; print_newline();
  with W_lexer.Eof ->()

