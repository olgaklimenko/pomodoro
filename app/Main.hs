module Main where
import Pomodoro (pomodoro)
import Interpreter (interpretPomodoro)
import Config (mockConfig)

main :: IO ()
main = interpretPomodoro mockConfig pomodoro
