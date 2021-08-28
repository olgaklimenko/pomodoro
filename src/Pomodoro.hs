{-# LANGUAGE DeriveFunctor #-}
module Pomodoro (Pomodoro,
      PomodoroF(GetChoice, StartTimer),
      Choice(..),
      pomodoro, 
      ) 
      where

import Control.Monad.Trans.Free (Free, FreeF(..), liftF)
import qualified Data.Time.Clock as Time
import Control.Monad (forever)
import Model (DefaultChoice(WorkDefault), Choice)

data PomodoroF next = 
    StartTimer Choice next
    | GetChoice DefaultChoice (Choice -> next)
    deriving Functor

type Pomodoro = Free PomodoroF

startTimer :: Choice -> Pomodoro ()
startTimer choice = liftF (StartTimer choice ())

getChoice :: DefaultChoice -> Pomodoro Choice
getChoice defaultChoice = liftF (GetChoice defaultChoice id)

pomodoro :: Pomodoro ()
pomodoro = 
    forever $ getChoice WorkDefault >>= startTimer

