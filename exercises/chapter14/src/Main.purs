module Main where

import Prelude

import Data.DOM.Phantom as Phantom
import Data.DOM.Simple as Simple
import Data.DOM.Smart as Smart
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)

main ∷ Effect Unit
main = do

  ------------
  -- Simple --
  ------------

  log $ Simple.render $ Simple.Element
    { name: "p"
    , attribs: [ Simple.Attribute { key: "class", value: "main" } ]
    , content: Just [ Simple.TextContent "Hello World!" ]
    }

  -----------
  -- Smart --
  -----------

  log $ Smart.render $ Smart.p [ Smart._class Smart.:= "main" ] [ Smart.text "Hello World!" ]
  log $ Smart.render $ Smart.img [ Smart.src Smart.:= "cat.jpg", Smart.width Smart.:= "foo", Smart.height Smart.:= "bar" ]

  -------------
  -- Phantom --
  -------------

  log $ Phantom.render $ Phantom.p [ Phantom._class Phantom.:= "main" ] [ Phantom.text "Hello World!" ]
  -- Compiler Error! (as expected)
  -- log $ Phantom.render $ Phantom.img [ Phantom.src Phantom.:= "cat.jpg", Phantom.width Phantom.:= "foo", Phantom.height Phantom.:= "bar" ]
  log $ Phantom.render $ Phantom.img [ Phantom.src Phantom.:= "cat.jpg", Phantom.width Phantom.:= 100, Phantom.height Phantom.:= 200 ]
