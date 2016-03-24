(* :Title: 	NCSimplifyRational *)

(* :Author: 	mauricio. *)

(* :Context: 	NCSimplifyRational` *)

(* :Summary:
*)

(* :Alias:
*)

(* :Warnings: 
*)

(* :History:
*)

BeginPackage[ "NCSimplifyRational`",
              "NCSubstitute`",
              "NCCollect`",
              "NCPolynomial`",
              "NCUtil`",
              "NonCommutativeMultiply`" ];

Clear[NCNormalizeInverse, 
      NCSimplifyRational];

Get["NCSimplifyRational.usage"];

Begin["`Private`"]

  Clear[ninv];
  NCNormalizeInverse[expr__] :=
    (((expr //. inv[x_] -> ninv[0, x]) 
            //. (ninv[a_, b__?CommutativeQ + c_] -> 
                       ninv[1, c/(a+Times[b])]/(a+Times[b])))
            //. ninv[a_, x_] -> inv[a + x])

  Clear[NCSimplifyRationalRules];
  Clear[a,b,K];
  SetCommutative[K];
  SetNonCommutative[a,b];

  Clear[NCSimplifyRationalABRules];
  NCSimplifyRationalABRules =
  {
      
      (*---------------------------RULE 1---------------------------*) 
      (* rule 1 is as follows:                                      *) 
      (*    inv[a] inv[1 + K a b] -> inv[a] - K b inv[1 + K a b]    *) 
      (*    inv[a] inv[1 + K a] -> inv[a] - K inv[1 + K a]          *)
      (*------------------------------------------------------------*)
      inv[a_]**inv[1 + K_. a_**b_] :> inv[a] - K b**inv[1 + K a**b],
      inv[a_]**inv[1 + K_. a_] :> inv[a] - K inv[1 + K a],

      (*-----------------------RULE 2-------------------------------*) 
      (* rule 2 is as follows:                                      *) 
      (*    inv[1 + K a b] inv[b] -> inv[b] - K inv[1 + K a b] a    *) 
      (*                   -> inv[b] - K a inv[1 + K a b] (rule #6) *) 
      (*    inv[1 + K a] inv[a] -> inv[a] - K inv[1 + K a ]         *) 
      (*------------------------------------------------------------*)
      inv[1 + K_. a_**b_]**inv[b_] :> inv[b] - K a**inv[1 + K a**b],
      inv[1 + K_. a_]**inv[a_] :> inv[a] - K inv[1 + K a],
      
      (*---------------------------------RULE 6---------------------*) 
      (* rule 6 is as follows:                                      *)
      (*      inv[1 + K a b] a  =  a inv[1 + K b a]                 *) 
      (*------------------------------------------------------------*)
      inv[1 + K_. a_**b_]**a_ :> a**inv[1 + K b**a]
      
  };

  Clear[NCSimplifyRationalAuxRules];
  NCSimplifyRationalAuxRules[terms_, rat_] := Module[
    {last = Last[terms], rest = (Plus @@ Most[terms]), factor},
      
    (* Normalize last *)
    factor = Replace[last, 
                {A_?CommutativeQ (_NonCommutativeMultiply|_Symbol) -> A, 
                 (_NonCommutativeMultiply|_Symbol) -> 1 }];
      
    last /= factor;
    rest /= factor;

    (*
    Print["terms = ", terms];
    Print["factor = ", factor];
    Print["last = ", last];
    Print["rest = ", rest];
    *)
      
    Return[{ rat ** last -> ExpandNonCommutativeMultiply[1/factor - rat ** rest],
             last ** rat -> ExpandNonCommutativeMultiply[1/factor - rest ** rat] }];
      
  ];

  NCSimplifyRational[expr_List] := 
     Map[NCSimplifyRational, expr];
  
  NCSimplifyRational[expr_] := Module[
    {poly, rvars, rules, simpRules, tmp},

    (* Convert from rational to polynomial *)
    {poly,rvars,rules} = NCRationalToNCPolynomial[NCNormalizeInverse[expr]];

    (*
    Print["expr = ", expr];
    Print["poly = ", poly];
    Print["rvars = ", rvars];
    Print["rules = ", rules];
    Print["P0 = ", Map[FullForm[#[[2,1]]]&, rules]];
    Print["P1 = ", Map[NCToNCPolynomial[#[[2,1]]]&, rules]];
    *)

    (* Not rational? return *)
    If [rvars === {},
        Return[expr];
    ];
      
    (* Create Rules *)
    simpRules = Reverse[
        Map[NCSimplifyRationalAuxRules[
                NCPSort[NCToNCPolynomial[#[[2,1]]]], 
                #[[1]]]&, rules]];

    (* Print["simpRules = ", simpRules]; *)

    tmp = NCPolynomialToNC[poly];

    (* Print["tmp0 = ", tmp]; *)

    (* Apply rules *)
    Scan[(tmp = ExpandAll[ExpandNonCommutativeMultiply[NCReplaceAll[tmp, #]]])&, simpRules];
      
    (* Print["tmp1 = ", tmp]; *)

    (* Bring back rational terms *)

    tmp = tmp //. rules;

    (* Print["tmp2 = ", tmp]; *)

    (* Apply AB rules *)
      
    tmp = ExpandAll[ExpandNonCommutativeMultiply[
              NCReplaceRepeated[tmp, NCSimplifyRationalABRules]]];

    (* Print["tmp = ", tmp]; *)
      
    Return[tmp];
      
  ];
        
End[];

EndPackage[];
