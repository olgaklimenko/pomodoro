module Model (DefaultChoice(..), Choice(..)) where
import qualified Data.Time.Clock as Time

data DefaultChoice = 
    ShortDefault 
    | LongDefault 
    | WorkDefault 
    deriving Show

data Choice = 
    ShortChoice Time.UTCTime 
    | LongChoice Time.UTCTime 
    | WorkChoice Time.UTCTime 
    deriving Show