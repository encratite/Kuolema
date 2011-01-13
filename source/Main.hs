{-# LANGUAGE CPP #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

#ifdef PRODUCTION
import Snap.Extension.Server
#else
import Snap.Extension.Loader.Devel
import Snap.Http.Server (quickHttpServe)
#endif

import Application
import Site

main :: IO ()
#ifdef PRODUCTION
main = quickHttpServe applicationInitialisation site
#else
main = do
  snap <- $(loadSnapTH 'applicationInitialisation 'site)
  quickHttpServe snap
#endif
