main.html = "<canvas id='container'></canvas>"

class SnowEffect
	constructor: (elm, @count, @size, @speed) ->
		@canvas = {elm: elm}
		window.addEventListener 'resize', @init
		@init()
	
	init: =>
		@setSize()
		@draw()
	
	setSize: ->
		@canvas.width = Screen.width
		@canvas.height = main.height
			
	draw: ->
		if @ticker
			clearInterval(@ticker)
			@ticker = null        
		@p = []
		@context = @canvas.elm.getContext('2d')
		@canvas.elm.width = Screen.width
		@canvas.elm.height = main.height
		@play()

	tick: ->
		@context.clearRect 0, 0, Screen.width, main.height
		@makeParticle() while @p.length < @count
		
		for par in @p
			par.x += Math.cos(par.sway += 0.1)
			par.y += par.yVelocity
		
		if par.yVelocity > 0 && par.y > @canvas.height + par.size
			par.y = -par.size
			par.x = Math.random() * Screen.width
		else if par.yVelocity < 0 && par.y < -par.size
			par.y = main.height + par.size
			par.x = Math.random() * Screen.width
		
		@context.fillStyle = 'rgba(255,255,255,' + par.opacity + ')'
		@context.beginPath()
		@context.arc par.x, par.y, par.size, 0, Math.PI * 2, true
		@context.closePath()
		@context.fill()

	makeParticle: ->
		@p.push
			x: Utils.randomNumber(0, Screen.width)
			y: Utils.randomNumber(0, Screen.height)
			yVelocity: Utils.randomNumber(2, 8) * @speed
			size: Utils.randomNumber(2, 5) * @size
			opacity: Utils.randomNumber(0.5, 1)
			sway:  Math.random() * 20

	play: ->
		@ticker = setInterval =>
			@tick()
		, 30
  
	togglePlay: ->
		if @ticker
			clearInterval(@ticker)
			@ticker = null
		else @play()

	adjust: (prop, val) ->
		@[prop] = val
		@draw()
	
	randomNum: (min, max) ->
		Math.random() * (max - min) + min
		
elm =  document.getElementById('container')
if elm then window.snow = new SnowEffect(elm, 500, 1, .8)
	
		