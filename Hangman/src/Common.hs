module Common where

dictLoc :: FilePath
dictLoc = "src/wordlist.txt" -- file with words for singleplayer
    
codeWord :: String -> String
codeWord = map (\x -> if x == ' ' then ' ' else '-')

safeHead :: String -> Char
safeHead "" = 'a'
safeHead x = head x

update :: String -> String -> Char -> String
update [] _ _ = []
update (word:ws) (code:cs) input | word == input = word : update ws cs input
                                 | otherwise = code : update ws cs input