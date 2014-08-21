class Router

  constructor: (@target) ->

  form: ->
    history.replaceState null, null, '/'
    app.pollId = null
    Q( $.get '/polls/new' ).then( (html) => @target.html(html) ).done()

  editor: (id) ->
    Q( $.get "/polls/#{id}/edit" ).then( (html) => @target.html(html)).done()

  poll: ->
    Q( $.get "/polls/#{app.pollId}" ).then( (html) => @target.html(html)).done()


@Router = Router
