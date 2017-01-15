# scn_title.nim
# Copyright (c) 2017 Vladar
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Vladar vladar4@gmail.com

import
  nimgame2 / [
    assets,
    entity,
    font,
    input,
    nimgame,
    scene,
    settings,
    textgraphic,
    types],
  data, scn_main


type
  ScnTitle* = ref object of Scene


var
  titleScene*: ScnTitle


proc free*(scn: ScnTitle) =
  freeData()


proc init*(scn: ScnTitle) =
  Scene(scn).init()
  let
    titleText = newEntity()
    titleTextG = newTextGraphic(fntData["default8x16"])
    infoText = newEntity()
    infoTextG = newTextGraphic(fntData["default8x16"])

  titleTextG.lines = [" Nimgame 2 Planetoids ",
                      "______________________",
                      "",
                      "press any key to start"]
  titleTextG.align = center
  titleText.graphic = titleTextG
  titleText.centrify()
  titleText.center.y = 0
  titleText.pos = (game.size.w / 2 / game.scale.x, 32 / game.scale.y)

  infoTextG.lines = ["Nimgame 2 Planetoids v1.0"]
  infoText.graphic = infoTextG
  infoText.scale = 0.5
  infoText.pos = (8 / game.scale.x, (game.size.h.float - 20) / game.scale.y)

  # add to scene
  scn.add(titleText)
  scn.add(infoText)


method event*(scn: ScnTitle, event: Event) =
  if event.kind == KeyDown:
    case event.key.keysym.scancode:
      of ScancodeEscape:
        gameRunning = false
      of ScancodeF11: # show info
        showInfo = not showInfo
      else: # switch to the main scene
        game.scene = mainScene
  elif event.kind == MouseButtonDown:
    game.scene = mainScene


proc newScnTitle*(): ScnTitle =
  new result, free
  result.init()


method show*(scn: ScnTitle) =
  discard


method update*(scn: ScnTitle, elapsed: float) =
  scn.updateScene(elapsed)
