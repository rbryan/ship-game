(export
 * + - / < <= = > >=
 append apply begin bytevector
 call-with-current-continuation call-with-values  call/cc cond-expand
 eq? equal? eqv? even? expt
 floor-quotient floor-remainder for-each include include-ci
 lambda let-syntax letrec-syntax list map modulo not odd?
 quasiquote quote quotient remainder set! string syntax-error syntax-rules
 truncate-quotient truncate-remainder vector vector-append)
;; Sorted by classname
(import (only (gnu kawa functions AddOp) + -))
(import (only (gnu kawa functions CallCC)
              (callcc call-with-current-continuation)
              (callcc call/cc)))
(import (only (gnu kawa functions DivideOp)
              (floorQuotient floor-quotient)
              (modulo floor-remainder)
              (quotient truncate-quotient)
              (remainder truncate-remainder)))
(import (only (gnu kawa functions DivideOp) / modulo quotient remainder))
(import (only (gnu kawa functions MultiplyOp) *))
(import  (only (gnu kawa lispexpr LangObjType)
               (listType list) (stringType string) (vectorType vector)
               (u8vectorType bytevector)))
(import (rename (only (kawa lang Quote) plainQuote quasiQuote)
                (plainQuote quote) (quasiQuote quasiquote)))
;(import (rename (only (kawa lib prim_syntax) letrec) (letrec letrec*)))
(import (only (kawa standard append) append))
(import (only (kawa standard begin) begin))
(import (rename (only (gnu kawa functions CallWithValues) callWithValues)
                (callWithValues call-with-values)))
(import (only (kawa standard expt) expt))
(import (rename (only (kawa standard IfFeature) condExpand)
                (condExpand cond-expand)))
(import (rename (only (kawa standard Include) include includeCi)
                (includeCi include-ci)))
(import (rename (only (kawa standard let_syntax) let_syntax letrec_syntax)
                (let_syntax let-syntax) (letrec_syntax letrec-syntax)))
(import (rename (only (kawa standard Scheme)
                      apply forEach isOdd isEven isEq isEqv isEqual
                      numEqu numGrt numGEq numLss numLEq map not)
                (forEach for-each)
                (isOdd odd?)
                (isEven even?)
                (isEq eq?) (isEqv eqv?) (isEqual equal?)
                (numEqu =) (numGrt >) (numGEq >=) (numLss <) (numLEq <=)))
(import (only (kawa standard SchemeCompilation) lambda))
(import (rename (only (kawa standard set_b) set) (set set!)))
(import (rename (only (kawa standard syntax_error) syntax_error)
                (syntax_error syntax-error)))
(import (rename (only (kawa standard syntax_rules) syntax_rules)
                (syntax_rules syntax-rules)))
(import (rename (only (kawa standard vector_append) vectorAppend)
                (vectorAppend vector-append)))
