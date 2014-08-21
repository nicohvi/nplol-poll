class Auth

  constructor: ->
    @url = '/auth/google_oauth2'
    if $('.current-user').length > 0 then @loggedIn = true else @loggedIn = false
    @initBindings()

  initBindings: ->
    if @loggedIn
      $('.logout').on 'ajax:complete', =>
        @logout()
    else
      $('.login').on 'click', (event) =>
        params = 'location=0,status=0,width=800,height=600'
        googleWindow = window.open(@url, 'googleWindow', params)
        googleWindow.focus()

  login: (pollId) ->
    @loggedIn = true
    @updateHeader(pollId)

  logout: ->
    @loggedIn = false
    @updateHeader()

  updateHeader: (pollId = null) ->
    if pollId? then url = "/current_user?poll_id=#{pollId}" else url = "/current_user"
    Q( $.get url )
    .then(
      (html) =>
        $('header').html(html)
        @initBindings()
    ).done()

@Auth = Auth
