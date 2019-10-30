module Hangman where
 
import System.Random as Rand
import EvilMode
import Common

type Mode = Int

nextRound :: Mode -> IO()
nextRound mode = case mode of
                     1 -> onePlayer
                     2 -> twoPlayer
                     _ -> evil

onePlayer :: IO()
onePlayer = do file <- readFile dictLoc  -- readFile gets a handle for file then read into file and closes it
               seed <- Rand.newStdGen  -- generate random seed using IO
               let dict = map init (lines file)  -- filters words into lines then remove the break lines by mapping init
                   (n, _) = Rand.randomR (0, (length dict) -1) seed :: (Int, StdGen)  -- generate random int based on seed
                   word = dict !! n  -- pick word based on random
               putStrLn "\nNew Round"
               start word 1 -- start with word in single player mode

twoPlayer :: IO()
twoPlayer = do putStrLn "Write the word to be guessed by next user or 'quit' to stop:"
               input <- getLine
               putStr "\ESC[2J" -- moves terminal down to stop user seeing the input from before
               if input == "quit" then putStrLn "END" else do start input 2

start :: String -> Mode -> IO()
start word mode = hangman word (codeWord word) lives mode where
    lives = 20 -- adjust lives here

hangman :: String -> String -> Int -> Mode -> IO()
hangman word code lives mode | word ==  code = do putStrLn "You Win!"
                                                  nextRound mode
                             | lives <= 0    = do putStrLn ("You Lose! Word was: " ++ word)
                                                  nextRound mode
                             | otherwise     = do putStrLn (show code)
                                                  putStrLn (show lives ++ " Remaining lives\n" ++ "Guess letter: ")
                                                  input <- getLine  -- getChar has bug where new line is considered 
                                                  hangman word (update word code (safeHead input)) (lives - 1) mode
