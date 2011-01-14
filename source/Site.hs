{-# LANGUAGE OverloadedStrings #-}

module Site
       ( site
       ) where

import Control.Applicative
import Data.IORef

import Text.Templating.Heist

import qualified Data.ByteString.Char8 as B
import qualified Text.XML.Expat.Tree as X

import Snap.Extension.Heist
import Snap.Util.FileServe
import Snap.Types

import Application

import Control.Monad.Reader

testSplice :: Splice Application
testSplice = do
  reference <- asks counter
  value <- liftIO $ readIORef reference
  liftIO $ writeIORef reference (value + 1)
  return [X.Text $ B.pack $ show $ value]

index :: Application ()
index = ifTop $ heistLocal (bindSplices splices) $ render "index"
  where
    splices =
        [ ("test", testSplice)
        ]

site :: Application ()
site = route [ ("/", index)
             ]
       <|> fileServe "static"
