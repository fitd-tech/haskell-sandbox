module Exercises.Exercise_4_2 where

-- General Recursion
-- We need to know how to prepend to a List
-- https://hackage.haskell.org/package/base-4.19.1.0/docs/Data-List-NonEmpty.html#v:cons
replicate_ :: Int -> a -> [a]
replicate_ size value = 
  if size <= 0
    then []
    else value : replicate_ (size - 1) value

-- It's fitting that in 4.3 we learn about show (https://hackage.haskell.org/package/base-4.19.1.0/docs/Text-Show.html#t:Show) and type classes
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

-- Partial Functions
-- For this section, let's at least try to handle the obvious gap in our function input coverage above
isEvenMoreComplete n =
  if n == 0
    then True
  else if n < 0
    then isOddMoreComplete (n + 1)
    else isOddMoreComplete (n - 1)

isOddMoreComplete n =
  if n == 0
    then False
  else if n < 0
    then isEvenMoreComplete (n + 1)
    else isEvenMoreComplete (n - 1)

exercise_4_2_partialFunctions = (putStrLn . boolToString) (isOddMoreComplete (-56))