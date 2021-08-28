module Interpreter (interpretPomodoro) where
import Control.Monad.Trans.Free (FreeF(..), runFree, liftF)
import Pomodoro
    ( Pomodoro,
      PomodoroF(GetChoice, StartTimer),
      Choice(..),
      )
import Config (PomodoroConfig(..))
import qualified Data.Time.Clock as Time
import Control.Monad.Reader
    ( MonadIO(liftIO), asks, ReaderT(runReaderT) )
import Model (DefaultChoice(..), Choice(..))

interpretPomodoro :: PomodoroConfig -> Pomodoro a -> IO a
interpretPomodoro config p = 
    case runFree p of
    Pure r -> return r
    Free (StartTimer choice next) -> do
        runReaderT (startTimerInterpreter choice) config
        interpretPomodoro config next
    Free (GetChoice defaultChoice next) -> do
        userChoice <- getChoiceInterpreter defaultChoice
        interpretPomodoro config $ next userChoice 

getChoiceInterpreter :: DefaultChoice -> IO Choice
getChoiceInterpreter defaultChoice = do
    case defaultChoice of
            -- highlight default with another color 
            ShortDefault -> do
                print $ "Type 1) to start a short break (default)"
                print $ "     2) to start a long break"
                print $ "     3) to start a new work period right now"
                choice <- getLine
                currentTime <- Time.getCurrentTime
                case choice of
                        "2" -> pure $ LongChoice currentTime
                        "3" -> pure $ WorkChoice currentTime
                        _ -> pure $ ShortChoice currentTime
            LongDefault -> do
                print $ "Type 1) to start a short break"
                print $ "     2) to start a long break (default)"
                print $ "     3) to start a new work period right now"
                choice <- getLine
                currentTime <- Time.getCurrentTime
                pure $ case choice of
                        "1" -> ShortChoice currentTime
                        "3" -> WorkChoice currentTime
                        _ -> LongChoice currentTime
            _ -> do
                print $ "Type 1) to start a short break"
                print $ "     2) to start a long break"
                print $ "     3) to start a new work period right now (default)"
                choice <- getLine
                currentTime <- Time.getCurrentTime
                pure $ case choice of
                        "1" -> ShortChoice currentTime
                        "2" -> LongChoice currentTime
                        _ -> WorkChoice currentTime

startTimerInterpreter ::  Choice -> ReaderT PomodoroConfig IO ()
startTimerInterpreter (WorkChoice t) =  do
    duration <- asks workDuration
    liftIO . putStrLn $ "First Pomodoro have started at " <> show t <> " for " <> show duration <> " minutes"
        -- start loop with check if timeout occurred
        -- write the start to mvar
startTimerInterpreter (ShortChoice t) = do
    duration <- asks shortBreak
    liftIO . putStrLn $ "Long break have started at " <> show t <> " for " <> show duration <> " minutes"
        -- start loop with check if timeout occurred
        -- write the start to mvar
startTimerInterpreter (LongChoice t) = do
    duration <- asks longBreak
    liftIO . putStrLn $ "Long break have started at " <> show t <> " for " <> show duration <> " minutes"
        -- start loop with check if timeout occurred
        -- write the start to mvar