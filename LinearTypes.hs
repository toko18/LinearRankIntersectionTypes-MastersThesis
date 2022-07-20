module LinearTypes where

import LambdaCalculus

-- Linear rank 0 intersection types (linear types).
data TLinearRank0 = TVar TyVar | TAp TLinearRank0 TLinearRank0
            deriving Eq

data TyVar = TyVar String
             deriving Eq

type EqSet = [(TLinearRank0, TLinearRank0)]

type Sub = (TyVar, TLinearRank0)

type Subst = [Sub]

data Unifier = Uni Subst | FAIL
               deriving (Eq, Show)

instance Show TLinearRank0 where
    show (TVar a)    = show a
    show (TAp t1 t2) = ('(':show t1) ++ (' ':'-':'o':' ':show t2) ++ [')']

instance Show TyVar where
    show (TyVar a) = id a


-------Type Unification-------

-- Given a Sub s=(a,t) and a linear type t0, replaces all free
-- occurrences of the type variable a in the type t0 with type t.
subst :: Sub -> TLinearRank0 -> TLinearRank0
subst (a1, t) (TVar a2) | a1 == a2  = t
                        | otherwise = TVar a2
subst s (TAp t1 t2)                 = TAp (subst s t1) (subst s t2)

-- Given a Sub s=(a,t) and an set of equations eqset, replaces all free
-- occurrences of the type variable a in the types in eqset with type t.
substE :: Sub -> EqSet -> EqSet
substE _ []           = []
substE s ((t1,t2):ts) = (t1',t2'):ts'
                     where t1' = subst s t1
                           t2' = subst s t2
                           ts' = substE s ts

-- Given a Sub s=(a,t) and an a type substitution subst, replaces all free
-- occurrences of the type variable a in the types in subst with type t.
substS :: Sub -> Subst -> Subst
substS _ []           = []
substS s ((t1,t2):ts) = (t1',t2'):ts'
                     where TVar t1' = subst s (TVar t1)
                           t2'      = subst s t2
                           ts'      = substS s ts

-- Checks if a type variable occurs (free) in a linear type.
isFVType :: TyVar -> TLinearRank0 -> Bool
isFVType a1 (TVar a2)  = a1 == a2
isFVType a (TAp t1 t2) = isFVType a t1 || isFVType a t2

-- Checks if a type variable occurs (free) in an equation set.
isFVTypeE :: TyVar -> EqSet -> Bool
isFVTypeE _ []            = False
isFVTypeE a ((t1, t2):ts) = isFVType a t1 || isFVType a t2 || isFVTypeE a ts

-- Checks if a type variable occurs (free) in a type substitution.
isFVTypeS :: TyVar -> Subst -> Bool
isFVTypeS _ []            = False
isFVTypeS a ((t1, t2):ts) = isFVType a (TVar t1) || isFVType a t2 || isFVTypeS a ts

-- Unification algorithm with counting of quantitative information.
-- (The third element of the tuples is the counter of the quantitative information.)
unifyQ :: (EqSet, Unifier, Int) -> (EqSet, Unifier, Int)
unifyQ ([], u, count)                          = ([], u, count)
unifyQ ((t1, t2):ts, u, count) | t1 == t2      = unifyQ (ts, u, count)
unifyQ ((TAp t1 t2, TAp t1' t2'):ts, u, count) = unifyQ ((t1, t1'):(t2, t2'):ts, u, count+1)
unifyQ ((TAp t1 t2, TVar a):ts, u, count)      = unifyQ ((TVar a, TAp t1 t2):ts, u, count)
unifyQ ((TVar a, t):ts, Uni s, count)
     | isFVType a t                    = error ("FAIL - trying to unify: " ++ show ((TVar a, t):ts, Uni s)) -- ([], FAIL)
     | isFVTypeE a ts || isFVTypeS a s = let ts' = substE (a, t) ts
                                             s'  = substS (a, t) s
                                             in unifyQ (ts', Uni ((a, t):s'), count)
     | otherwise                       = unifyQ (ts, Uni ((a, t):s), count)
