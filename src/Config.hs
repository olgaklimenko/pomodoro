module Config (PomodoroConfig(..), mockConfig) where
import qualified Data.Time.Clock as Time

type Duration = Time.NominalDiffTime

data PomodoroConfig = PomodoroConfig {
    workDuration :: Duration,
    shortBreak :: Duration,
    longBreak :: Duration
} deriving Show

mockConfig :: PomodoroConfig
mockConfig = PomodoroConfig {
    workDuration = 45,
    shortBreak = 5,
    longBreak = 15
}
