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
  setHeistState wrappedState applicationState = applicationState { templateState = wrappedState }

applicationInitialisation :: Initializer ApplicationState
applicationInitialisation = do
  heist <- heistInitializer templatePath
  return $ ApplicationState heist