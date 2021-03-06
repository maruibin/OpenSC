open AST
open Ctypes
open Datatypes
open Globalenvs
open Integers
open Language
open Maps0

type node = ident

type statement =
| Sskip of node
| Sassign of expr * expr * node
| Sset of ident * expr * node
| Scall of ident option * label * expr list * node
| Scond of expr * node * node
| Sreturn of expr option * node
| Sdone
| Stransfer of expr * expr * node * node
| Scallmethod of expr * ident list * Int.int * expr * expr list * node * node
| Slog of expr * node
| Srevert

type code = statement PTree.t

type coq_function = { fn_return : coq_type;
                      fn_params : (ident, coq_type) prod list;
                      fn_temps : (ident, coq_type) prod list; fn_code : 
                      code; fn_entrypoint : node }

val fn_return : coq_function -> coq_type

val fn_params : coq_function -> (ident, coq_type) prod list

val fn_temps : coq_function -> (ident, coq_type) prod list

val fn_code : coq_function -> code

val fn_entrypoint : coq_function -> node

type genv = (coq_function, coq_type) Genv.t
