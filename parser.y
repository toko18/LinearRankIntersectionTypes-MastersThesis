{
module Main where

import Data.Char
import LambdaCalculus
import Reductions
import SimpleTypes
import Rank2IntersectionTypes
import LinearTypes
import LinearRank2QuantitativeTypes
}

%name parse
%tokentype { Token }
%error { parseError }

%token
  '\\'            { TokenLambda     }
  '.'             { TokenPoint      }
  ' '             { TokenSpace      }
  var             { TokenVar $$     }
  '('             { TokenOB         }
  ')'             { TokenCB         }
  typeinf0        { TokenInf0       }
  typeinf2        { TokenInf2       }
  qtypeinf2       { TokenQInf2      }
  reduceMax       { TokenReduceMax  }
  reduceNorm      { TokenReduceNorm }
  reduceApp       { TokenReduceApp  }
  steps           { TokenSteps      }
  count           { TokenCount      }

%left '.'
%left ' '

%%

Exp   : TyInf                                      { TyInf $1     }
      | Term                                       { Term $1      }
      | Reduction                                  { Reduction $1 }

Term  : var                                        { Var (TeVar $1) }
      | Abs                                        { $1             }
      | App                                        { $1             }
      | '(' Term ')'                               { $2             }

Abs   : '\\' var '.' Term                          { Abs (TeVar $2) $4 }

App   : Term ' ' Term                              { App $1 $3 }

TyInf : typeinf0 ' ' '(' Term ')'                  { TyInf0 $4 (simpleTypeInf $4 0)           }
      | typeinf2 ' ' '(' Term ')'                  { TyInf2 $4 (r2typeInf $4 0)               }
      | qtypeinf2 ' ' '(' Term ')'                 { QTyInf2 $4 (quantR2typeInf $4 0) Default }
      | qtypeinf2 ' ' '(' Term ')' ' ' count       { QTyInf2 $4 (quantR2typeInf $4 0) Count   }

Reduction : reduceMax ' ' '(' Term ')'             { Reduct "maximal strategy" $4 (reduce maximal [$4] 0) Default         }
          | reduceNorm ' ' '(' Term ')'            { Reduct "normal strategy" $4 (reduce normal [$4] 0) Default           }
          | reduceApp ' ' '(' Term ')'             { Reduct "applicative strategy" $4 (reduce applicative [$4] 0) Default }
          | reduceMax ' ' '(' Term ')' ' ' steps   { Reduct "maximal strategy" $4 (reduce maximal [$4] 0) Steps           }
          | reduceNorm ' ' '(' Term ')' ' ' steps  { Reduct "normal strategy" $4 (reduce normal [$4] 0) Steps             }
          | reduceApp ' ' '(' Term ')' ' ' steps   { Reduct "applicative strategy" $4 (reduce applicative [$4] 0) Steps   }
          | reduceMax ' ' '(' Term ')' ' ' count   { Reduct "maximal strategy" $4 (reduce maximal [$4] 0) Count           }
          | reduceNorm ' ' '(' Term ')' ' ' count  { Reduct "normal strategy" $4 (reduce normal [$4] 0) Count             }
          | reduceApp ' ' '(' Term ')' ' ' count   { Reduct "applicative strategy" $4 (reduce applicative [$4] 0) Count   }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"

data Exp
      = TyInf TyInf
      | Reduction Reduction
      | Term Term

data TyInf
      = TyInf0 Term (Basis, Type0, Int)
      | TyInf2 Term (Env, Type2, Int)
      | QTyInf2 Term (LEnv, TLinearRank2, Int ,Int) Mode

data Reduction  -- Reduct Reduction_strategy Term Initial_term (Reverse_list_of_reductions, Number_reductions) Mode_of_printing
      = Reduct String Term ([Term], Int) Mode

data Mode
      = Default  -- shows everything (except reduction steps, in the case of Reduct)
      | Count    -- only shows the counters
      | Steps    -- (only for Reduct) shows everything, with reduction steps

instance Show Exp where
    show (TyInf x)     = show x
    show (Reduction x) = show x
    show (Term x)      = "Term: " ++ show x ++ ['\n']

instance Show TyInf where
    show (TyInf0 term (basis, t0, _))           = "\t[--- Inference (simple types) ---]" ++ "\n\tTerm        = " ++ show term ++ "\n\tBasis       = " ++ show basis ++ "\n\tType        = " ++ show t0 ++ ['\n']
    show (TyInf2 term (env, t0, _))             = "\t[--- Inference (rank 2 intersection types) ---]" ++ "\n\tTerm        = " ++ show term ++ "\n\tEnvironment = " ++ show env ++ "\n\tType        = " ++ show t0 ++ ['\n']
    show (QTyInf2 term (env, t2, c, _) Default) = "\t[--- Inference (linear rank 2 quantitative types) ---]" ++ "\n\tTerm        = " ++ show term ++ "\n\tEnvironment = " ++ show env ++ "\n\tType        = " ++ show t2 ++ "\n\tCount       = " ++ show c ++ ['\n']
    show (QTyInf2 term (env, t2, c, _) Count)   = "\t[--- Inference (linear rank 2 quantitative types) ---]" ++ "\n\tTerm        = " ++ show term ++ "\n\tCount       = " ++ show c ++ ['\n']

instance Show Reduction where
    show (Reduct strat term (terms, c) Default) = "\t[--- Reduction (" ++ strat ++ ") ---]" ++ "\n\tTerm        = " ++ show term ++ "\n\tNormal form = " ++ show (head terms) ++ "\n\tCount       = " ++ show c ++ ['\n']
    show (Reduct strat term (terms, c) Steps)   = "\t[--- Reduction (" ++ strat ++ ") ---]" ++ "\n\tTerm        = " ++ show term ++ "\n\tNormal form = " ++ show (head terms) ++ "\n\tCount       = " ++ show c ++ "\n\tReductions:    " ++ show (head (reverse terms)) ++ "\n" ++ concat (map (\x -> "\t            -> " ++ show x ++ "\n") (tail (reverse terms)))
    show (Reduct strat term (terms, c) Count)   = "\t[--- Reduction (" ++ strat ++ ") ---]" ++ "\n\tTerm        = " ++ show term ++ "\n\tCount       = " ++ show c ++ ['\n']

data Token
      = TokenLambda
      | TokenPoint
      | TokenSpace
      | TokenVar String
      | TokenOB
      | TokenCB
      | TokenInf0
      | TokenInf2
      | TokenQInf2
      | TokenReduceMax
      | TokenReduceNorm
      | TokenReduceApp
      | TokenSteps
      | TokenCount
      deriving Show

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs)
 | isAlphaNum c = lexVar (c:cs)
lexer ('\\':cs) = TokenLambda : lexer cs
lexer ('.':cs)  = TokenPoint : lexer cs
lexer (' ':cs)  = TokenSpace : lexer cs
lexer ('(':cs)  = TokenOB : lexer cs
lexer (')':cs)  = TokenCB : lexer cs

lexVar cs =
   case span isAlphaNum cs of
      ("ti0",rest)        -> TokenInf0 : lexer rest
      ("ti2",rest)        -> TokenInf2 : lexer rest
      ("qti2",rest)       -> TokenQInf2 : lexer rest
      ("reduceMax",rest)  -> TokenReduceMax : lexer rest
      ("reduceNorm",rest) -> TokenReduceNorm : lexer rest
      ("reduceApp",rest)  -> TokenReduceApp : lexer rest
      ("steps",rest)      -> TokenSteps : lexer rest
      ("count",rest)      -> TokenCount : lexer rest
      (var,rest)          -> TokenVar var : lexer rest

main = do line <- getLine
          let action | all isSpace line || line!!0 == '#' = main
                     | line!!0 == '-'                     = putStrLn (tail line)
                     | otherwise                          = (print . parse . lexer) line
          action
          main
}
