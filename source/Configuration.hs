module Configuration
       ( templatePath
       ) where

import System.FilePath

staticPath = "static"
getStaticPath path = staticPath </> path
templatePath = getStaticPath "template"