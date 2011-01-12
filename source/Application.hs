module Application
       ( Application
       , applicationInitialisation
       ) where

import Snap.Extension
import Snap.Extension.Heist.Impl

import Configuration

type Application = SnapExtend ApplicationState

data ApplicationState = ApplicationState
                        { templateState :: HeistState Application
                        }

instance HasHeistState Application ApplicationState where
  getHeistState = templateState
  setHeistState s a = a { templateState = s }

  applicationInitialisation :: Initializer ApplicationState
  applicationInitialisation = do
    heist <- heistInitializer templateState
    return $ ApplicationState heist