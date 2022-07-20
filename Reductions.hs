module Reductions where

import LambdaCalculus
import Data.List

type Sub = (TeVar, Term)

removeAll :: Eq a => a -> [a] -> [a]
removeAll x = filter (/= x)

intersection :: Eq a => [a] -> [a] -> [a]
intersection l1 l2 = nub (intersect l1 l2)

inBetaNF :: Term -> Bool
inBetaNF (Var _)           = True
inBetaNF (App (Abs _ _) _) = False
inBetaNF (Abs _ m)         = inBetaNF m
inBetaNF (App m1 m2)       = inBetaNF m1 && inBetaNF m2

renameFree1 :: Term -> TeVar -> Term
renameFree1 (Var (TeVar x)) y | (TeVar x) == y = Var (TeVar (x++"'"))
                              | otherwise      = Var (TeVar x)
renameFree1 (Abs x m) y | x == y               = Abs x m
                        | otherwise            = Abs x (renameFree1 m y)
renameFree1 (App m1 m2) y                      = App (renameFree1 m1 y) (renameFree1 m2 y)

renameBV :: Term -> [TeVar] -> Term
renameBV (Var x) _                                = Var x
renameBV (Abs (TeVar x) m) xs | elem (TeVar x) xs = Abs (TeVar (x++"'")) (renameBV (renameFree1 m (TeVar x)) xs)
                              | otherwise         = Abs (TeVar x) (renameBV m xs)
renameBV (App m1 m2) xs                           = App (renameBV m1 xs) (renameBV m2 xs)

substitute :: Sub -> Term -> Term
substitute (TeVar x1, m1) m2 | length (inter) > 0 = substitute (TeVar x1, m1) m2'
                            where inter = intersection (boundVars m2) (freeVars m1)
                                  m2'   = renameBV m2 inter
substitute (x1, m) (Var x2) | x1 == x2            = m
                            | otherwise           = Var x2
substitute (x1, m1) (Abs x2 m2) | x1 == x2        = Abs x2 m2
                                | otherwise       = Abs x2 (substitute (x1, m1) m2)
substitute s (App m1 m2)                          = App (substitute s m1) (substitute s m2)

boundVars :: Term -> [TeVar]
boundVars (Var _)     = []
boundVars (Abs x m)   = x:boundVars m
boundVars (App m1 m2) = boundVars m1 ++ boundVars m2

freeVars :: Term -> [TeVar]
freeVars (Var x)     = [x]
freeVars (Abs x m)   = removeAll x (freeVars m)
freeVars (App m1 m2) = freeVars m1 ++ freeVars m2

isFV :: TeVar -> Term -> Bool
isFV x t = elem x (freeVars t)


-------Maximal Beta-reduction Strategy (based on Def. 3.21 (Cap. 3.5) from 'Perpetual Reductions in Lambda-Calculus'-------

isXParrow :: Term -> Bool
isXParrow (Var x)     = True
isXParrow (App m1 m2) = inBetaNF m2 && isXParrow m1
isXParrow _           = False

maximal :: Term -> (Term, Int)
maximal m | inBetaNF m                          = (m, 0)
maximal (Abs x m)                               = let (m', n) = maximal m
                                                  in (Abs x m', n)
maximal (App (Abs x m1) m2)
            | isFV x m1 || inBetaNF m2          = (substitute (x, m2) m1, 1)
            | otherwise                         = let (m2', n) = maximal m2
                                                  in (App (Abs x m1) m2', n)
maximal (App m1 m2) -- Rule 1
            | not (inBetaNF m2) && isXParrow m1 = let (m2', n) = maximal m2
                                                  in (App m1 m2', n)
maximal (App m1 m2)                             = let (m1', n) = maximal m1
                                                  in (App m1' m2, n)


-------Normal Order Beta-reduction Strategy-------

normal :: Term -> (Term, Int)
normal m | inBetaNF m                  = (m, 0)
normal (Abs x m)                       = let (m', n) = normal m in (Abs x m', n)
normal (App (Abs x m1) m2)             = (substitute (x, m2) m1, 1)
normal (App m1 m2) | not (inBetaNF m1) = let (m1', n) = normal m1 in (App m1' m2, n)
                   | otherwise         = let (m2', n) = normal m2 in (App m1 m2', n)


-------Applicative Order Beta-reduction Strategy-------

applicative :: Term -> (Term, Int)
applicative m | inBetaNF m                          = (m, 0)
applicative (Abs x m)                               = let (m', n) = applicative m in (Abs x m', n)
applicative (App (Abs x m1) m2) | not (inBetaNF m2) = let (m2', n) = applicative m2 in (App (Abs x m1) m2', n)
                                | not (inBetaNF m1) = let (m1', n) = applicative m1 in (App (Abs x m1') m2, n)
                                | otherwise         = (substitute (x, m2) m1, 1)
applicative (App m1 m2) | not (inBetaNF m1)         = let (m1', n) = applicative m1 in (App m1' m2, n)
                        | otherwise                 = let (m2', n) = applicative m2 in (App m1 m2', n)


maxSteps :: Int
maxSteps = 1000

reduce :: (Term -> (Term, Int)) -> [Term] -> Int -> ([Term], Int)
reduce strat (m:ms) n0 | n0 > maxSteps = (((Var (TeVar ("Limit Exceeded. Current term: " ++ show m))):ms), n0)
                       | inBetaNF m    = ((m:ms), n0)
                       | otherwise     = reduce strat (m':m:ms) (n0+n1)
                      where (m', n1) = strat m
