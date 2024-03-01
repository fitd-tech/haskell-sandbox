module Main where

main :: IO ()
-- 3.1
-- main = putStrLn "<html><body>Hello, Haskell!</body></html>"

-- wrapHtml content = "<html><body>" <> content <> "</body></html>"
-- myhtml = wrapHtml "Hello, Haskell!"

-- 3.1.1
html_ :: String -> String
html_ content = "<html>" <> content <> "</html>"
body_ :: String -> String
body_ content = "<body>" <> content <> "</body>"
-- 3.1.2
--myhtml = html_ (body_ "Hello, Haskell!")
-- 3.1.3
head_ :: String -> String
head_ content = "<head>" <> content <> "</head>"
title_ :: String -> String
title_ content = "<title>" <> content <> "</title>"
-- 3.1.4
makeHtml :: String -> String -> String
makeHtml title body = html_ (head_ (title_ title) <> body_ body)
myhtml :: String
myhtml = makeHtml "Learn Haskell by building a blog generator" "This isn't a link yet but: https://learn-haskell.blog/"
-- main = putStrLn myhtml

-- 3.2
el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"
-- 3.2.bonus
-- This is how the above looks under the hood, with lambda functions
-- el = \tag -> \content -> "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

html_3_2_ :: String -> String
html_3_2_ = el "html"
body_3_2_ :: String -> String
body_3_2_ = el "body"

-- 3.2.2
head_3_2_ :: String -> String
head_3_2_ = el "head"
title_3_2_ :: String -> String
title_3_2_ = el "title"
p_3_2_ :: String -> String
p_3_2_ = el "p"
h1_3_2_ :: String -> String
h1_3_2_ = el "h1"
a_3_2_ :: String -> String
a_3_2_ = el "a"

-- It's interesting that we use a trailing underscore for the names and not the parameters
-- Meaning the underscore doesn't seem to be appended to prevent shadowing in scope, because it's used at the top level
makeHtml_3_2 :: String -> String -> String -> String
makeHtml_3_2 title heading bodyText = html_3_2_ (head_3_2_ (title_3_2_ title) <> body_3_2_ (h1_3_2_ heading <> p_3_2_ bodyText))
-- 3.2.bonus
-- Let's see if this works using lambdas ✅
-- makeHtml_3_2 = \title -> \heading -> \bodyText -> html_3_2_ (head_3_2_ (title_3_2_ title) <> body_3_2_ (h1_3_2_ heading <> p_3_2_ bodyText))
myHtml :: String
myHtml = makeHtml_3_2 "Learn Haskell by building a blog generator" "Haskell tutorial" "This isn't a link yet but: https://learn-haskell.blog/"
-- The solution wants us to leave makeHtml_3_2 with only the two parameters (title, content) and format the the content here like this:
-- myHtml = makeHtml_3_2 "Learn Haskell by building a blog generator" (h1_3_2_ "Haskell tutorial" <> p_3_2_ "This isn't a link yet but: https://learn-haskell.blog/")
-- This method is more modular, but I get the idea

main = putStrLn myHtml