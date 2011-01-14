module Application
       ( Application
       , applicationInitialisation
       , counter
       ) where

import Data.IORef
import Control.Monad.Trans

import Snap.Extension
import Snap.Extension.Heist.Impl

import Configuration

type Application = SnapExtend ApplicationState

data ApplicationState = ApplicationState
                        { templateState :: HeistState Application,
                          counter :: IORef Int
                        }

instance HasHeistState Application ApplicationState where
  getHeistState = templateState
  setHeistState wrappedState applicationState = applicationState { templateState = wrappedState }

applicationInitialisation :: Initializer ApplicationState
applicationInitialisation = do
  heist <- heistInitializer templatePath
  newCounter <- liftIO $ newIORef 0
  return $ ApplicationState heist newCounter