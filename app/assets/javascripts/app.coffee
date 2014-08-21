class App

  constructor: (@el) ->
    @pollId = null
    if $('.current-user').length > 0 then @loggedIn = true else @loggedIn = false
    @auth = new Auth()
    @router = new Router(@el)
    @initBindings()

  initBindings: ->
    @el.on 'auth', =>
      @loggedIn = true
      @auth.updateHeader()
      @router.poll() if @poll

    @el.on 'header', =>
      @tipsy()

    @el.on 'poll:new', =>
      return @router.form() unless $('#poll-form').length > 0 # Called from popstate
      @form = new PollForm($('#poll-form'))
      @auth.updateHeader()

    @el.on 'poll:edit', (event, data) =>
      return @router.editor() unless data? # Called through popstate

      if data.html? # the form was added through an AJAX call
        @el.html(data.html)
        @auth.updateHeader()
      else # only add the poll-editor once the DOM has loaded.
        @pollId = data.id
        @pollEditor = new PollEditor($('#poll-edit'))
        window.history.pushState { action: 'edit' }, null, "/polls/#{@pollId}/edit"

    @el.on 'poll:show', (event, data) =>
      @pollId = data.id
      @poll = new Poll($('#poll-container'))

    # If the history entry has a state it was manually added, otherwise we
    # load the root page.
    $(window).on 'popstate', (event) =>
      state = event.originalEvent.state
      if state && state.action? then $('#main').trigger('poll:edit') else $('#main').trigger('poll:new')

  unbind: ->
    $(document).off 'keydown'

  tipsy: ->
    $('.tipsy').remove()
    $('i').tipsy gravity: 'n'

@App = App
