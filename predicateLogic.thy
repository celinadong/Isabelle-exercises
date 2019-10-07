(*
    ex.thy,v 1.1 2016/09/29 17:37:37 jdf Exp
    Original Author: Tjark Weber
    Updated to Isabelle 2016 by Jacques Fleuriot
*)

section {* Predicate Logic *}

 theory predicateLogic imports Main begin 

text {*
We are again talking about proofs in the calculus of Natural Deduction.  In
addition to the rules given in the exercise "Propositional Logic", you may
now also use

exI: ?P ?x \<Longrightarrow> \<exists>x. ?P x
exE:\<lbrakk>\<exists>x. ?P x; \<And>x. ?P x \<Longrightarrow> ?Q\<rbrakk> \<Longrightarrow> ?Q
allI: (\<And>x. ?P x) \<Longrightarrow> \<forall>x. ?P x
allE: \<lbrakk>\<forall>x. ?P x; ?P ?x \<Longrightarrow> ?R\<rbrakk> \<Longrightarrow> ?R

Give a proof of the following propositions or an argument why the formula is
not valid:
*}
 
  
lemma "(\<exists>x. \<forall>y. P x y) \<longrightarrow> (\<forall>y. \<exists>x. P x y)"
  apply (rule impI)
  apply (rule allI)
  apply (erule exE)
  apply (rule exI)
  apply (erule allE)
  apply assumption
  done

lemma "(\<forall>x. P x \<longrightarrow> Q) = ((\<exists>x. P x) \<longrightarrow> Q)"
  apply (rule iffI)
   apply (rule impI)
   apply (erule exE)
  apply (erule allE)
   apply (erule impE)
    apply assumption+
  apply (rule allI)
  apply (rule impI)
  apply (erule impE)
   apply (rule exI)
   apply assumption+
  done

lemma "((\<forall> x. P x) \<and> (\<forall> x. Q x)) = (\<forall> x. (P x \<and> Q x))"
  apply (rule iffI)
   apply (rule allI)
   apply (erule conjE)
  apply (erule allE)+
   apply (rule conjI)
    apply assumption+
  apply (rule conjI)
   apply (rule allI)
   apply (erule allE)
   apply (erule conjE)
   apply assumption
  apply (rule allI)
  apply (erule allE)
  apply (erule conjE)
  apply assumption
  done

lemma "((\<forall> x. P x) \<or> (\<forall> x. Q x)) = (\<forall> x. (P x \<or> Q x))"
  apply (rule iffI)
   apply (rule allI)
   apply (erule disjE)
    apply (rule disjI1)
    apply (erule allE)
    apply assumption
  apply (rule disjI2)
   apply (erule allE)
   apply assumption
  apply (rule classical)
(* invalid: only provable one way*)
 oops 

lemma "((\<exists> x. P x) \<or> (\<exists> x. Q x)) = (\<exists> x. (P x \<or> Q x))"
  apply (rule iffI)
   apply (erule disjE)
    apply (erule exE)
  apply (rule exI)
    apply (rule disjI1)
    apply assumption
   apply (erule exE)
   apply (rule exI)
   apply (rule disjI2)
   apply assumption
  apply (erule exE)
  apply (erule disjE)
   apply (rule disjI1)
   apply (rule exI)
   apply assumption
  apply (rule disjI2)
  apply (rule exI)
  apply assumption
  done

lemma "(\<forall>x. \<exists>y. P x y) \<longrightarrow> (\<exists>y. \<forall>x. P x y)"
  apply (rule impI)
  apply (erule allE)
  apply (erule exE)
  apply (rule exI)
  apply (rule allI)
 oops 

lemma "(\<not> (\<forall> x. P x)) = (\<exists> x. \<not> P x)"
  apply (rule iffI)
   prefer 2
   apply (erule exE)
   apply (rule notI)
   apply (erule allE)
   apply (erule notE)
   apply assumption
  apply (rule exI)
   apply (rule notI)
   apply (erule notE)
   apply (rule allI)
(*invalid?*)
 oops 

 end 