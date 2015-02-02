 $(document).asEventStream('click', '.js-edit-option')
  .debounceImmediate 1000
  .map (event) -> $(event.target).parents('.option:first')
  .onValue ($el) -> 
      $el.find('.name').toggle()
      $el.find('form').toggle()

#variables
#options = $('.options')
#optionInput = $('#new_option input').val('')
#notice = $('.notice')

 #functions
#toggleForm = ($option, name = null) ->
  #name ||= $option.find('.name').text()
  #$option.find('.name').toggle().text(name)
  #$option.find('.edit_option').toggle()
  #$option.find('.edit_option #option_name').focus() if $('.edit_option').is(':visible')

#toggleTitle = (name = null) ->
  #name = name || $('.form').find('#poll_name').val()
  #$('.form').toggle().find('#poll_name').focus()
  #$('.poll-title h1').text(name).toggle()

#showMessage = (message, error=false) ->
  #Bacon.once(notice.find('p').text(message))
  #.map -> notice.removeClass('hidden transition')
  #.delay(800)
  #.doAction -> notice.addClass('transition')
  #.delay(800)
  #.onValue -> notice.addClass('hidden')

#disableForms = ->
  #$('button, input[type="checkbox"]').addClass('disabled')
  #$(document).on 'ajax:before', -> false

#enableForms = ->
  #$('button, input[type="checkbox"]').removeClass('disabled')
  #$(document).off 'ajax:before'

 #streams
#$(document).asEventStream('ajax:send').onValue -> disableForms()
#$(document).asEventStream('ajax:success ajax:error').onValue -> enableForms()

#newOptionStream = $(document).asEventStream 'ajax:success', '#new_option', (event, data, status, xhr) -> data

#editOptionStream = $(document).asEventStream 'ajax:success', '.edit_option'
  #.map (event) -> $(event.target)

#editPollStream = $(document).asEventStream 'ajax:success', '.edit_poll'
  #.map (event) -> title: $(event.target).find('#poll_name').val()

#$('#poll_allow_anonymous').asEventStream('click')
  #.merge($('.submit').asEventStream('click'))
  #.debounceImmediate(1000)
  #.onValue (event) -> $(event.target).parents('form:first').trigger('submit.rails')

#deleteOptionStream = $(document).asEventStream 'ajax:success', '.delete-option'
  #.map (event) -> $(event.target).parents('.option:first')

#$(document).asEventStream 'ajax:error'
  #.onValue (json) -> console.log "something bad happened#{json}"

#$(document).asEventStream 'click', '.edit-option'
  #.onValue (event) -> toggleForm $(event.target).parents('.option:first')

#$(document).asEventStream 'click', '.edit-title'
  #.onValue (event) -> toggleTitle()

 #subscribers
#newOptionStream
  #.doAction -> optionInput.val ''
  #.onValue (html) ->
    #options.append html
    #options.find('.option:last i').tipsy { gravity: 'n' }

#editOptionStream.onValue ($form) -> toggleForm $form.parents('.option:first'), $form.find('#option_name').val()

#editPollStream.onValue (data) ->
  #toggleTitle(data.title) if data.title?
  #showMessage("Poll information updated")

#deleteOptionStream.onValue ($option) ->
  #$('.tipsy').remove()
  #$option.remove()
