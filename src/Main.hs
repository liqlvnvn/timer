module Main where

import System.Environment (getArgs)
import System.Console.GetOpt
import Control.Monad (when)
import Control.Concurrent (threadDelay)

import Data.Time
import Data.Time.Clock.POSIX
--import Utils.Helpers
--
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
    --    Start a    -> startTimer a
        Stop       -> putStrLn "Stop"
        Status     -> putStrLn "Status"

startTimer :: Integer -> UTCTime -> TimeZone -> IO()
startTimer arg startTime zone = do
    -- arg - number of seconds we want to wait
    let diffTimeTillEnd  = secondsToDiffTime arg
    let utcTimeTillEnd = UTCTime {utctDay=(utctDay startTime),utctDayTime=diffTimeTillEnd}
    putStrLn $ show startTime 
    putStrLn $ show utcTimeTillEnd
    let endTimeInSeconds = utcTimeToPOSIXSeconds startTime 
                         + utcTimeToPOSIXSeconds utcTimeTillEnd
    let endTime = posixSecondsToUTCTime endTimeInSeconds
    timerLoop endTime zone

timerLoop :: UTCTime -> TimeZone -> IO ()
timerLoop endTime zone = do 
    currentTime <- getCurrentTime
    threadDelay 1000000
    putStrLn $ show $ utcToLocalTime zone currentTime
    putStrLn $ show $ utcToLocalTime zone endTime
    when (currentTime < endTime) (timerLoop endTime zone)

main :: IO ()
main = do
    args <- getArgs
    --print p
    print args
    zone <- getCurrentTimeZone
    --utcToLocalTime zone
    cTime <- getCurrentTime
    startTimer 10 cTime zone
