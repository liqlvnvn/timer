module Main where

import System.Environment (getArgs)
import System.Console.GetOpt

import Data.Time
--import Utils.Helpers

data Flag = Start String
          | Stop
          | Status
          deriving Show

options :: [OptDescr Flag]
options =
    [ Option ['s'] ["start"]  (ReqArg Start "MINUTES") "initialize timer"
    , Option ['b'] ["stop"]   (NoArg Stop)             "stop timer"
    , Option ['i'] ["status"] (NoArg Status)           "check status"
    ]

compilerOpts :: [String] -> IO [Flag]
compilerOpts argv =
    case getOpt RequireOrder options argv of
        (o,_,[] )  -> return o
        (_,_,err)  -> ioError $ userError $ concat err ++ 
                                                usageInfo header options
                      where header = "Usage: ic [OPTION...] param"

selectAction :: IO [Flag] -> IO ()
selectAction list = do 
    flag <- list
    case head flag of
        Start a    -> startTimer a
        Stop       -> putStrLn "Stop"
        Status     -> putStrLn "Status"

startTimer :: String -> IO()
startTimer arg =
    putStrLn arg

main :: IO ()
main = do
    args <- getArgs
    --print p
    print args
    t <- getCurrentTime
    print t
    zone <- getCurrentTimeZone
    let tl = utcToLocalTime zone t
    print tl
