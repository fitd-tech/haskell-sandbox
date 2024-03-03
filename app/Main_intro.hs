-- https://learn-haskell.blog/
module Main where

-- I suppose we'll just wrestle with names in this file until we learn about modules :D
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
myHtml = makeHtml_3_2 "Learn Haskell by building a blog generator" "Haskell tutorial" "This isn't a link yet, but maybe it will be: https://learn-haskell.blog/"
-- The solution wants us to leave makeHtml_3_2 with only the two parameters (title, content) and format the the content here like this:
-- myHtml = makeHtml_3_2 "Learn Haskell by building a blog generator" (h1_3_2_ "Haskell tutorial" <> p_3_2_ "This isn't a link yet but: https://learn-haskell.blog/")
-- This method is more modular, but I get the idea

-- main = putStrLn myHtml

-- 3.4

-- This is what we were told was the proper append_ definition...but see below for the REAL proper one!
-- append_ :: Structure -> Structure -> Structure
-- append_ (Structure a) (Structure b) = Structure (a <> b)

p_3_4_ :: String -> Structure
p_3_4_ = Structure . el "p"
-- "Pen and paper" type checking:
-- Type of .:
-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- Type of Structure:
-- Structure :: String -> Structure
-- Type of el "p":
-- el "p" :: String -> String
-- . expects two arguments, so we are matching the requirements so far
-- Match String -> Structure with b -> c
-- b ~ String
-- c ~ Structure
-- Match String -> String with a -> b
-- a ~ String
-- b ~ String (but we knew that already)
-- So the matched type looks like:
-- (.) :: (String -> Structure) -> (String -> String) -> (String -> Structure)
-- So the expression type is:
-- Structure . el "p" :: String -> Structure
-- which Haskell knows and our tooltips tell us, but this helps us debug the type checker when we get an error

-- Note block regarding parametrically polymorphic functions (aka generics):
-- Each instance of a function has its own type variables that can share names without conflicting
-- (I need to understand how to convert these values first in order to test this)
id :: p -> p
id a = a
-- This should convert a character to an integer
--ord character = character
--chr integer = integer
--incrementChar c = chr (ord (id c) + id 1)
-- Then the note wants us to try doing this with a function that's not at the top level to show it doesn't work:
--incrementCharFail func c = chr (ord (func c) + func 1)

-- The section that prompted us to come up with the below is aptly called "The rest of the owl"
-- and there was no way I was going to infer this in a beginner Haskell tutorial.
-- So I'm just typing it all out to start, I guess?

main = putStrLn (render myHtml_3_4)

myHtml_3_4 =
  html_3_4_
    "My title"
    (append_
      (h1_3_4_ "Heading")
      (append_
        (p_3_4_ "Paragraph #1")
        (p_3_4_ "Paragraph #2")
      )
    )

newtype Html = Html String
newtype Structure = Structure String
type Title = String

html_3_4_ title content =
  Html
    (el_3_4_ "html"
      (el_3_4_ "head" (el_3_4_ "title" title)
        <> el_3_4_ "body" (getStructureString content)
      )
    )

-- p_3_4_ is defined above, where we worked out the type matching
h1_3_4_ = Structure . el_3_4_ "h1"
el_3_4_ tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"



append_ c1 c2 = Structure (getStructureString c1 <> getStructureString c2)
getStructureString content =
  case content of
    Structure str -> str
render :: Html -> String
render html =
  case html of
    Html str -> str

-- Whew, it works. Now we get to escape this naming mess with modules!