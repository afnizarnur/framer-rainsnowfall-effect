# p5.js Configuration
canvas = new Layer
	width: screen.width
	height: main.height
	parent: main
	
canvas.html = "<div id='canvas'></div>"

weatherEffect = new p5 (p) ->
	p.setup = ->
		effect_canvas = p.createCanvas(canvas.width, canvas.height)
		effect_canvas.parent("canvas")
		
	p.draw = ->
		
				