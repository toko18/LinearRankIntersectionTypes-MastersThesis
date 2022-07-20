module LinearRank2QuantitativeTypes where

import LambdaCalculus
import LinearTypes

-- Linear rank 1 intersection types.
data TLinearRank1 = T1_0 TLinearRank0 | Inters TLinearRank1 TLinearRank1
             deriving Eq

-- Linear rank 2 intersection types.
data TLinearRank2 = T2_0 TLinearRank0 | T2ApL TLinearRank0 TLinearRank2 | T2Ap TLinearRank1 TLinearRank2
             deriving Eq

-- Environments.
type LEnv = [(TeVar, TLinearRank1)]

instance Show TLinearRank1 where
    show (T1_0 t0)       = show t0
    show (Inters t1 t2) = ('(':show t1) ++ ('/':'\\':show t2) ++ [')']

instance Show TLinearRank2 where
    show (T2_0 t)      = show t
    show (T2ApL t0 t2) = ('(':show t0) ++ (' ':'-':'o':' ':show t2) ++ [')']
    show (T2Ap t1 t2)  = ('(':show t1) ++ (' ':'-':'>':' ':show t2) ++ [')']


-- Note: every Int appearing in the last position of a returning tuple or
-- as the last argument of a function, is for generating new type variables (a1, a2, a3, ...).


-------Quantitative Type Inference Algorithm-------

-- Given a list of linear rank 1 intersection types, returns a single type
-- consisting of the intersection of the types in the given list.
listToInters :: [TLinearRank1] -> TLinearRank1
listToInters [t1]    = t1
listToInters (t1:ts) = Inters (listToInters ts) t1

-- Checks if a linear rank 1 type is also a linear rank 0 type (i.e., if it does not have intersections).
t1isT0 :: TLinearRank1 -> Bool
t1isT0 (T1_0 _) = True
t1isT0 _        = False

-- Converts a linear rank 1 type t to a linear rank 0 type, if t is also a linear rank 0 type (i.e., if
-- it does not have intersections); otherwise, fails.
t1toT0 :: TLinearRank1 -> TLinearRank0
t1toT0 (T1_0 t0) = t0
t1toT0 t1        = error ("FAIL - t1toT0 error: the type " ++ show t1 ++ " is not a linear rank 0 type.\n")

-- Converts a linear rank 2 type t to a linear rank 0 type, if t is also a linear rank 0 type (i.e., if
-- it does not have any intersections); otherwise, fails.
t2toT0 :: TLinearRank2 -> TLinearRank0
t2toT0 (T2_0 t0)     = t0
t2toT0 (T2ApL t0 t2) = TAp t0 (t2toT0 t2)
t2toT0 (T2Ap t1 t2)  = error ("FAIL - t2toT0 error: the type " ++ show (T2Ap t1 t2) ++ " is not a linear rank 0 type.\n")

-- Given a Sub s=(a,t) and a linear rank 1 intersection type t1, replaces all free
-- occurrences of the type variable a in the type t1 with type t.
subst1 :: Sub -> TLinearRank1 -> TLinearRank1
subst1 s (T1_0 t0)       = T1_0 (subst s t0)
subst1 s (Inters t1 t1') = Inters (subst1 s t1) (subst1 s t1')

-- Given a Sub s=(a,t) and a linear rank 2 intersection type t2, replaces all free
-- occurrences of the type variable a in the type t2 with type t.
subst2 :: Sub -> TLinearRank2 -> TLinearRank2
subst2 s (T2_0 t0)     = T2_0 (subst s t0)
subst2 s (T2ApL t0 t2) = T2ApL (subst s t0) (subst2 s t2)
subst2 s (T2Ap t1 t2)  = T2Ap (subst1 s t1) (subst2 s t2)

-- Applies a substitution to a linear rank 2 intersection type.
substty2 :: Subst -> TLinearRank2 -> TLinearRank2
substty2 [] t2     = t2
substty2 (s:ts) t2 = substty2 ts (subst2 s t2)

-- Given a Sub s=(a,t) and an environment env, replaces all free
-- occurrences of the type variable a in the types in env with type t.
substEn :: Sub -> LEnv -> LEnv
substEn _ []         = []
substEn s ((x,t):es) = (x, subst1 s t):substEn s es

-- Applies a substitution to an environment.
substEnv :: Subst -> LEnv -> LEnv
substEnv [] e     = e
substEnv (s:ts) e = substEnv ts (substEn s e)

-- Checks whether or not a term variable is in an environment.
isInEnv :: TeVar -> LEnv -> Bool
isInEnv _ []            = False
isInEnv x1 ((x2, _):es) = x1 == x2 || isInEnv x1 es

-- Given a term variable x and an environment env,
-- returns a list with all types of x in env.
findAllInEnv :: TeVar -> LEnv -> [TLinearRank1]
findAllInEnv _ []                        = []
findAllInEnv x1 ((x2, t):es) | x1 == x2  = t:findAllInEnv x1 es
                             | otherwise = findAllInEnv x1 es

-- Given a term variable x and an environment env,
-- returns the type of x in env.
-- (It is guaranteed that the function will only be called when
-- there is one and only one occurrence of x in env.)
findInEnv :: TeVar -> LEnv -> TLinearRank1
findInEnv x1 ((x2, t):es) | x1 == x2  = t
                          | otherwise = findInEnv x1 es

-- Removes all occurrences of a term variable from an environment.
rmFromEnv :: TeVar -> LEnv -> LEnv
rmFromEnv _ []                        = []
rmFromEnv x1 ((x2, t):es) | x1 == x2  = rmFromEnv x1 es
                          | otherwise = (x2, t):rmFromEnv x1 es

-- Given an environment, replaces all pairs (x,t1), (x,t2), ... with a same
-- term variable x with a single pair (x,t) where t=(t1/\t2/\...), ie,
-- the intersection type of t1, t2, ... .
mergeEnv :: LEnv -> LEnv
mergeEnv []           = []
mergeEnv ((x, t1):es) = (x, listToInters (findAllInEnv x ((x, t1):es))):mergeEnv (rmFromEnv x es)

-- Auxiliar of the type inference algorithm, performs as many type inferences for the given term
-- as the number of linear types of the given linear rank 1 sequence, and returns the environment
-- and the generated equations described in the algorithm.
-- (The third element of the returning tuple is the counter of the quantitative information.)
genEqs :: TLinearRank1 -> Term -> Int -> (LEnv, EqSet, Int, Int)
genEqs (T1_0 tau) m n0           = (env, [(t2toT0 t, tau)], b, n1) -- fails if M has a linear rank 2 type
                                where (env, t, b, n1) = quantR2typeInf m n0
genEqs (Inters tseq1 tseq2) m n0 = (mergeEnv (envs1++envs2), eqs1++eqs2, bs1+bs2, n2)
                                where (envs1, eqs1, bs1, n1) = genEqs tseq1 m n0
                                      (envs2, eqs2, bs2, n2) = genEqs tseq2 m n1

-- Type inference algorithm for linear rank 2 intersection types with counting of quantitative information.
-- (The third element of the returning tuple is the counter of the quantitative information.)
quantR2typeInf :: Term -> Int -> (LEnv, TLinearRank2, Int, Int)
quantR2typeInf (Var x) n0     = let a = TVar (TyVar ('a':(show n0))) in
                                    ([(x, T1_0 a)], T2_0 a, 0, n0+1)                                                                     -- Rule 1.

quantR2typeInf (Abs x m1) n0  = let (env1, sig1, b1, n1) = quantR2typeInf m1 n0 in
                                    if (isInEnv x env1)
                                    then let t1    = findInEnv x env1
                                             env1x = rmFromEnv x env1
                                         in if (t1isT0 t1)
                                            then (env1x, T2ApL (t1toT0 t1) sig1, b1, n1)                                                 -- Rule 2.b
                                            else (env1x, T2Ap t1 sig1, b1, n1)                                                           -- Rule 2.c
                                    else error ("FAIL - Rule 2.(a): " ++ show x ++ " not in " ++ show env1 ++ "\n")                      -- Rule 2.a

quantR2typeInf (App m1 m2) n0 = let (env1, sig1, b1, n1) = quantR2typeInf m1 n0 in
                                    case sig1 of
                                        T2_0 (TVar a1)     -> (substEnv s env, substty2 s (T2_0 a3), b1+b2, n2+2)                        -- Rule 3.a
                                                          where (env2, tau2, b2, n2) = quantR2typeInf m2 n1
                                                                env                  = mergeEnv (env1++env2)
                                                                a2                   = TVar (TyVar ('a':(show n2)))
                                                                a3                   = TVar (TyVar ('a':(show (n2+1))))
                                                                eqs                  = [(TVar a1, TAp a2 a3), (t2toT0 tau2, a2)]
                                                                ([], Uni s, _)       = unifyQ (eqs, Uni [], 0)

                                        T2Ap tseq sig1'    -> (substEnv s env, substty2 s sig1', b1+bs+b3+1, n2)                         -- Rule 3.b
                                                          where (envs, eqs, bs, n2)  = genEqs tseq m2 n1
                                                                env                  = mergeEnv (env1++envs)
                                                                ([], Uni s, b3)      = unifyQ (eqs, Uni [], 0)

                                        T2ApL tau sig      -> (substEnv s env, substty2 s sig, b1+b2+b3+1, n2)                           -- Rule 3.c
                                                          where (env2, tau2, b2, n2) = quantR2typeInf m2 n1
                                                                env                  = mergeEnv (env1++env2)
                                                                eqs                  = [(t2toT0 tau2, tau)]
                                                                ([], Uni s, b3)      = unifyQ (eqs, Uni [], 0)

                                        T2_0 (TAp tau sig) -> (substEnv s env, substty2 s (T2_0 sig), b1+b2+b3+1, n2)                    -- Rule 3.c
                                                          where (env2, tau2, b2, n2) = quantR2typeInf m2 n1
                                                                env                  = mergeEnv (env1++env2)
                                                                eqs                  = [(t2toT0 tau2, tau)]
                                                                ([], Uni s, b3)      = unifyQ (eqs, Uni [], 0)
