#jslint browser: true 
#global 

"use strict"
class MatrixCommands
  matrixStack = []

  constructor: (@liveCodeLabCore_THREE, @liveCodeLabCoreInstance) ->
    @worldMatrix = new @liveCodeLabCore_THREE.Matrix4()
    # These need to be global so it can be run by the draw function
    window.pushMatrix  = () => @pushMatrix()
    window.popMatrix   = () => @popMatrix()
    window.resetMatrix = () => @resetMatrix()
    window.move   = (a,b,c) => @move(a,b,c)
    window.rotate = (a,b,c) => @rotate(a,b,c)
    window.scale  = (a,b,c) => @scale(a,b,c)

  getWorldMatrix: ->
    @worldMatrix

  resetMatrixStack: ->
    @matrixStack = []
    @worldMatrix.identity()

  pushMatrix: ->
    @matrixStack.push @worldMatrix
    @worldMatrix = (new @liveCodeLabCore_THREE.Matrix4()).copy(@worldMatrix)

  popMatrix: ->
    if @matrixStack.length isnt 0
      @worldMatrix = @matrixStack.pop()
    else
      @worldMatrix.identity()

  resetMatrix: ->
    @worldMatrix.identity()

  move: (a, b, c = 0) ->
    if typeof a isnt "number"
      a = Math.sin(@liveCodeLabCoreInstance.TimeKeeper.getTime() / 500)
      b = Math.cos(@liveCodeLabCoreInstance.TimeKeeper.getTime() / 500)
      c = a
    else if typeof b isnt "number"
      b = a
      c = a
    @worldMatrix.translate new @liveCodeLabCore_THREE.Vector3(a, b, c)

  rotate: (a, b, c = 0) ->
    if typeof a isnt "number"
      a = @liveCodeLabCoreInstance.TimeKeeper.getTime() / 1000
      b = a
      c = a
    else if typeof b isnt "number"
      b = a
      c = a
    @worldMatrix.rotateX(a).rotateY(b).rotateZ c

  scale: (a, b, c = 1) ->
    if typeof a isnt "number"
      a = 1 + Math.sin(@liveCodeLabCoreInstance.TimeKeeper.getTime() / 500) / 4
      b = a
      c = a
    else if typeof b isnt "number"
      b = a
      c = a
    
    # odd things happen setting scale to zero
    a = 0.000000001  if a > -0.000000001 and a < 0.000000001
    b = 0.000000001  if b > -0.000000001 and b < 0.000000001
    c = 0.000000001  if c > -0.000000001 and c < 0.000000001
    @worldMatrix.scale new @liveCodeLabCore_THREE.Vector3(a, b, c)
