{-# LANGUAGE OverloadedStrings #-}

module Site
       ( site
       ) where

import Control.Applicative
import Text.Templating.Heist

import qualified Data.ByteString.Char8 as B
import qualified Text.XML.Expat.Tree as X

import Snap.Extension.Heist
import Snap.Util.FileServe
import Snap.Types

import Application

testSplice :: Splice Application
testSplice = return [X.Text $ B.pack $ show $ liftIO $ readIORef counter]

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
