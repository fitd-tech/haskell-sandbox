import Html
import Exercises
import Markup

main :: IO ()
-- main = putStrLn (render myhtml)
-- Call this when we want to print some independent exercise result
main = exercise_4_2_mutualRecursion

myhtml :: Html
myhtml =
  html_
    "My title > your title"
    (append_
      (h1_ "heading")
      (append_
        (p_ "Paragraph #1")
        (append_
          (p_ "Paragraph #2")
          (append_ 
            (ul_ 
              [ p_ "item 1"
              , p_ "item 2"
              , p_ "item 3"
              ]
            )
            (append_
              (ol_
                [ p_ "step #1"
                , p_ "step #2"
                , p_ "step #3"
                ]
              )
              (code_ "composedFn = function1 . function2")
            )
          )
        )
      )
    )