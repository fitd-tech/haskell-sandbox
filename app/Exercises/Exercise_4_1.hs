module Exercises.Exercise_4_1 where

-- Found by using Hoogle (https://hoogle.haskell.org) at the behest of the tutorial
import Numeric.Natural

-- Headings: prefix by a number of * characters
-- Paragraphs: a group of lines without empty lines in between
-- Unordered lists: a group of lines, each prefixed with -
-- Ordered lists: a group of lines, each prefixed with #
-- Code blocks: a group of lines, each prefixed with >

type Document = [Structure]
data Structure
  = Heading Natural String
  | Paragraph String
  | UnorderedList [String]
  | OrderedList [String]
  | CodeBlock [String]

-- 1
exercise_4_1_1 = 
  [ Paragraph "Hello, world!"
  ]

-- 2
exercise_4_1_2 = 
  [ Heading 1 "Welcome"
  , Paragraph "To this tutorial about Haskell."
  ]

exercise_4_1_3 =
  [ Paragraph "Remember that multiple lines with no separation are grouped together into a single paragraph but list items remain separate."
  , OrderedList 
    [ "Item 1 of a list"
    , "Item 2 of the same list" 
    ]
  ]

exercise_4_1_4 =
  [ Heading 1 "Compiling programs with ghc"
  , Paragraph "Running ghc invokes a the Glasgow Haskell Compilere (GHC), and can be used to compile Haskell modules and programs into native executables and libraries."
  , Paragraph "Create a new Haskell source file named hello.hs, and write the following code in it:"
  , CodeBlock 
    [ "main = putStrLn \"Hello, Haskell!\""
    ]
  , Paragraph "Now, we can compile the program by invoking ghc with the file name:"
  , CodeBlock 
    [ "➜ ghc hello.hs"
    , "[1 of 1] Compiling Main             ( hello.hs, hello.o )"
    , "Linking hello..."
    ]
  , Paragraph "GHC created the following files:"
  , UnorderedList
    [ "hello.hi - Haskell interface file"
    , "hello.o - Object file, the output of the compiler before linking"
    , "hello (or hello.exe on Microsoft Windows) - A native runnable executable." 
    ]
  , Paragraph "GHC will produce an executable when the source file satisfies both conditions:"
  , OrderedList 
    [ "Defines the main function in the source file"
    , "Defines the module name to be Main or does not have a module declaration" 
    ]
  , Paragraph "Otherwise, it will only produce the .o and .hi files."
  ]