open Ast 
open Sast
open List

module StringMap = Map.Make(String)




let check_ids id = function
  [] -> []
  | hd :: tl -> []

(* need to implement *)
let rec check_sexpr e = function
  [] -> []
  | hd :: tl -> []

let rec check_consturctor_def c = function
   [] -> []
  | c.name n -> check_sexpr n
  | c.params ps -> check_sexpr ps
  | c.consturctor_body cb -> check_sexpr cb 
  | c.retrun_type t -> check_type t

let rec check_method_def md = function
     [] -> []
   | hd :: tl -> (match hd with 
   |md.methodname n -> check_sexpr n 
   |md.params ps -> check_sexpr ps 
   |md.guard_body gb -> check_sexpr gb 
   |md.storage_body sb -> check_sexpr sb 
   |md.effects_body eb -> check_sexpr eb
   |md.returns rt -> check_type rt
   ) :: check_method_def tl 


let rec check_interfaces interface = function
  | [] -> []
  | interface.signaturename(e) -> check_sexpr e
  | interface.interfacebody(e) -> 
                          (match e with
                              | [] -> []
                              | hd :: tl -> check_sexpr hd :: check_interfaces tl)

let rec check_implementations implementation = function
  | [] -> []
  | implementation.consturctor(c) -> check_consturctor_def c
  | implementation.methods(ms) -> check_method_def ms


let check program = function
  | [] -> []
  | program.interface -> check_interfaces program.interface
  | program.implementation -> check_implementations program.imeplementations 
