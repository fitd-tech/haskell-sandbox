module Exercises.Exercise_4_2 where

-- General Recursion
-- We need to know how to prepend to a List
-- https://hackage.haskell.org/package/base-4.19.1.0/docs/Data-List-NonEmpty.html#v:cons
replicate_ :: Int -> a -> [a]
replicate_ size value = 
  if size <= 0
    then []
    else value : replicate_ (size - 1) value

boolToString :: Bool -> String
boolToString x =
  if x
    then "True"
    else "False"

-- exercise_4_2_generalRecursion = putStrLn (concat (map boolToString (replicate_ 6 True)))
-- An attempt to compose the above:
exercise_4_2_generalRecursion = (putStrLn . concat . (map boolToString)) (replicate_ 6 True)

-- Mutual Recursion
isEven :: (Eq a, Num a) => a -> Bool
isEven n =
  if n == 0
    then True
    else isOdd (n - 1)

isOdd :: (Eq a, Num a) => a -> Bool
isOdd n =
  if n == 0
    then False
    else isEven (n - 1)

exercise_4_2_mutualRecursion = (putStrLn . boolToString) (isEven 56)