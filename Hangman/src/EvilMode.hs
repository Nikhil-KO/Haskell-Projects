module EvilMode where

import System.Random as Rand
import Common
    
evil :: IO ()
evil = do putStrLn "under dev" 
          file <- readFile dictLoc  -- readFile gets a handle for file then read into file and closes it
          seed <- Rand.newStdGen  -- generate random seed using IO
          let dict = map init (lines file)  -- filters words into lines then remove the break lines by mapping init
              (n, _) = Rand.randomR (0, (length dict) -1) seed :: (Int, StdGen)  -- generate random int based on seed
              word = dict !! n  -- pick word based on random
          putStrLn "\nNew Round"
     
startEvil :: String -> IO()
startEvil word = do putStrLn "pl"         