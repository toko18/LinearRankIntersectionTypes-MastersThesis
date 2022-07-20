{-# OPTIONS_GHC -w #-}
module Main where

import Data.Char
import LambdaCalculus
import Reductions
import SimpleTypes
import Rank2IntersectionTypes
import LinearTypes
import LinearRank2QuantitativeTypes
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.8

data HappyAbsSyn t4 t5 t6 t7 t8 t9
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,104) ([45568,31,896,0,0,8,2048,0,8,0,0,8,0,0,0,0,0,16,0,0,50,2048,0,8,2048,0,32,8192,0,32,18432,0,4,12800,0,32,8192,0,32,12800,0,50,12800,0,0,12800,0,0,12800,0,50,12800,0,72,18432,0,72,2048,0,72,18432,0,72,0,0,0,2048,0,8,2048,0,8,0,96,24576,0,96,16384,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Exp","Term","Abs","App","TyInf","Reduction","'\\\\'","'.'","' '","var","'('","')'","typeinf0","typeinf2","qtypeinf2","reduceMax","reduceNorm","reduceApp","steps","count","%eof"]
        bit_start = st * 24
        bit_end = (st + 1) * 24
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..23]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (10) = happyShift action_11
action_0 (13) = happyShift action_12
action_0 (14) = happyShift action_13
action_0 (16) = happyShift action_3
action_0 (17) = happyShift action_4
action_0 (18) = happyShift action_5
action_0 (19) = happyShift action_14
action_0 (20) = happyShift action_15
action_0 (21) = happyShift action_16
action_0 (4) = happyGoto action_6
action_0 (5) = happyGoto action_7
action_0 (6) = happyGoto action_8
action_0 (7) = happyGoto action_9
action_0 (8) = happyGoto action_2
action_0 (9) = happyGoto action_10
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (16) = happyShift action_3
action_1 (17) = happyShift action_4
action_1 (18) = happyShift action_5
action_1 (8) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (12) = happyShift action_25
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (12) = happyShift action_24
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (12) = happyShift action_23
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (24) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (12) = happyShift action_22
action_7 _ = happyReduce_2

action_8 _ = happyReduce_5

action_9 _ = happyReduce_6

action_10 _ = happyReduce_3

action_11 (13) = happyShift action_21
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_4

action_13 (10) = happyShift action_11
action_13 (13) = happyShift action_12
action_13 (14) = happyShift action_13
action_13 (5) = happyGoto action_20
action_13 (6) = happyGoto action_8
action_13 (7) = happyGoto action_9
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (12) = happyShift action_19
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (12) = happyShift action_18
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (12) = happyShift action_17
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (14) = happyShift action_34
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (14) = happyShift action_33
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (14) = happyShift action_32
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (12) = happyShift action_22
action_20 (15) = happyShift action_31
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (11) = happyShift action_30
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (10) = happyShift action_11
action_22 (13) = happyShift action_12
action_22 (14) = happyShift action_13
action_22 (5) = happyGoto action_29
action_22 (6) = happyGoto action_8
action_22 (7) = happyGoto action_9
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (14) = happyShift action_28
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (14) = happyShift action_27
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (14) = happyShift action_26
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (10) = happyShift action_11
action_26 (13) = happyShift action_12
action_26 (14) = happyShift action_13
action_26 (5) = happyGoto action_41
action_26 (6) = happyGoto action_8
action_26 (7) = happyGoto action_9
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (10) = happyShift action_11
action_27 (13) = happyShift action_12
action_27 (14) = happyShift action_13
action_27 (5) = happyGoto action_40
action_27 (6) = happyGoto action_8
action_27 (7) = happyGoto action_9
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (10) = happyShift action_11
action_28 (13) = happyShift action_12
action_28 (14) = happyShift action_13
action_28 (5) = happyGoto action_39
action_28 (6) = happyGoto action_8
action_28 (7) = happyGoto action_9
action_28 _ = happyFail (happyExpListPerState 28)

action_29 _ = happyReduce_9

action_30 (10) = happyShift action_11
action_30 (13) = happyShift action_12
action_30 (14) = happyShift action_13
action_30 (5) = happyGoto action_38
action_30 (6) = happyGoto action_8
action_30 (7) = happyGoto action_9
action_30 _ = happyFail (happyExpListPerState 30)

action_31 _ = happyReduce_7

action_32 (10) = happyShift action_11
action_32 (13) = happyShift action_12
action_32 (14) = happyShift action_13
action_32 (5) = happyGoto action_37
action_32 (6) = happyGoto action_8
action_32 (7) = happyGoto action_9
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (10) = happyShift action_11
action_33 (13) = happyShift action_12
action_33 (14) = happyShift action_13
action_33 (5) = happyGoto action_36
action_33 (6) = happyGoto action_8
action_33 (7) = happyGoto action_9
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (10) = happyShift action_11
action_34 (13) = happyShift action_12
action_34 (14) = happyShift action_13
action_34 (5) = happyGoto action_35
action_34 (6) = happyGoto action_8
action_34 (7) = happyGoto action_9
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (12) = happyShift action_22
action_35 (15) = happyShift action_47
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (12) = happyShift action_22
action_36 (15) = happyShift action_46
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (12) = happyShift action_22
action_37 (15) = happyShift action_45
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (12) = happyShift action_22
action_38 _ = happyReduce_8

action_39 (12) = happyShift action_22
action_39 (15) = happyShift action_44
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (12) = happyShift action_22
action_40 (15) = happyShift action_43
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (12) = happyShift action_22
action_41 (15) = happyShift action_42
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_10

action_43 _ = happyReduce_11

action_44 (12) = happyShift action_51
action_44 _ = happyReduce_12

action_45 (12) = happyShift action_50
action_45 _ = happyReduce_14

action_46 (12) = happyShift action_49
action_46 _ = happyReduce_15

action_47 (12) = happyShift action_48
action_47 _ = happyReduce_16

action_48 (22) = happyShift action_57
action_48 (23) = happyShift action_58
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (22) = happyShift action_55
action_49 (23) = happyShift action_56
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (22) = happyShift action_53
action_50 (23) = happyShift action_54
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (23) = happyShift action_52
action_51 _ = happyFail (happyExpListPerState 51)

action_52 _ = happyReduce_13

action_53 _ = happyReduce_17

action_54 _ = happyReduce_20

action_55 _ = happyReduce_18

action_56 _ = happyReduce_21

action_57 _ = happyReduce_19

action_58 _ = happyReduce_22

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn4
		 (TyInf happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Term happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn4
		 (Reduction happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn5
		 (Var (TeVar happy_var_1)
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 4 6 happyReduction_8
happyReduction_8 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Abs (TeVar happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_3  7 happyReduction_9
happyReduction_9 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (App happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happyReduce 5 8 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (TyInf0 happy_var_4 (simpleTypeInf happy_var_4 0)
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 5 8 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (TyInf2 happy_var_4 (r2typeInf happy_var_4 0)
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 5 8 happyReduction_12
happyReduction_12 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (QTyInf2 happy_var_4 (quantR2typeInf happy_var_4 0) Default
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 7 8 happyReduction_13
happyReduction_13 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (QTyInf2 happy_var_4 (quantR2typeInf happy_var_4 0) Count
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 5 9 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "maximal strategy" happy_var_4 (reduce maximal [happy_var_4] 0) Default
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 5 9 happyReduction_15
happyReduction_15 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "normal strategy" happy_var_4 (reduce normal [happy_var_4] 0) Default
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 5 9 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "applicative strategy" happy_var_4 (reduce applicative [happy_var_4] 0) Default
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 7 9 happyReduction_17
happyReduction_17 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "maximal strategy" happy_var_4 (reduce maximal [happy_var_4] 0) Steps
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 7 9 happyReduction_18
happyReduction_18 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "normal strategy" happy_var_4 (reduce normal [happy_var_4] 0) Steps
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 7 9 happyReduction_19
happyReduction_19 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "applicative strategy" happy_var_4 (reduce applicative [happy_var_4] 0) Steps
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 7 9 happyReduction_20
happyReduction_20 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "maximal strategy" happy_var_4 (reduce maximal [happy_var_4] 0) Count
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 7 9 happyReduction_21
happyReduction_21 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "normal strategy" happy_var_4 (reduce normal [happy_var_4] 0) Count
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 7 9 happyReduction_22
happyReduction_22 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Reduct "applicative strategy" happy_var_4 (reduce applicative [happy_var_4] 0) Count
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 24 24 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenLambda -> cont 10;
	TokenPoint -> cont 11;
	TokenSpace -> cont 12;
	TokenVar happy_dollar_dollar -> cont 13;
	TokenOB -> cont 14;
	TokenCB -> cont 15;
	TokenInf0 -> cont 16;
	TokenInf2 -> cont 17;
	TokenQInf2 -> cont 18;
	TokenReduceMax -> cont 19;
	TokenReduceNorm -> cont 20;
	TokenReduceApp -> cont 21;
	TokenSteps -> cont 22;
	TokenCount -> cont 23;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 24 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "templates/GenericTemplate.hs" #-}



















































































































































































-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 











data Happy_IntList = HappyCons Int Happy_IntList




















infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action




indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

