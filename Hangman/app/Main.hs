module Main where

import Hangman
import System.IO
    
main :: IO ()
main = do putStrLn "Welcome to my simple hangman game, type in \n '1' to play single player or \n '2' for 2 player or \n '3' for a special mode"
          input <- getLine
          let n = (read input :: Int)
          nextRound n     