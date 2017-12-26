# p5.js Configuration
canvas = new Layer
	width: screen.width
	height: main.height
	parent: main
	
canvas.html = "<div id='canvas'></div>"

quantity = 20
xPosition = []
yPosition = []
flakeSize = []
direction = []
minFlakeSize = 1
maxFlakeSize = 5
snowColor = 255

weatherEffect = new p5 (p) ->
	drawSnow = ->
		i = 0
		while i < xPosition.length
			p.ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i])
			
			if direction[i] == 0
				xPosition[i] += p.map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5)
			else
				xPosition[i] -= p.map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5)
			
			yPosition[i] += flakeSize[i] + direction[i]
			
			if xPosition[i] > p.width + flakeSize[i] or xPosition[i] < -flakeSize[i] or yPosition[i] > p.height + flakeSize[i]
				xPosition[i] = p.random(0, p.width)
				yPosition[i] = -flakeSize[i]
			i++
		return

	p.setup = ->
		effect_canvas = p.createCanvas(canvas.width, canvas.height)
		effect_canvas.parent("canvas")
		p.frameRate(30);
		p.noStroke();
		i = 0
		while i < quantity
			flakeSize[i] = p.round(p.random(minFlakeSize, maxFlakeSize))
			xPosition[i] = p.random(0, p.width)
			yPosition[i] = p.random(0, p.height)
			direction[i] = p.round(p.random(0, 1))
			i++
		
	p.draw = ->
		drawSnow()
				