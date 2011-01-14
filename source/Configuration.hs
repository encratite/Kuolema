module Configuration
       ( staticPath
       , templatePath
       ) where

type Path = [Char]

staticPath :: Path
staticPath = "static"

templatePath :: Path
templatePath = "template"