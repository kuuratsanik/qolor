{CompositeDisposable, Point, Range} = require 'atom'

class QolorView extends HTMLElement
    # Private
    markers: []

    # Public
    initialize: () ->
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.workspace.observeTextEditors (editor) =>
            disposable = editor.onDidStopChanging =>
                @update editor

            editor.onDidDestroy -> disposable.dispose()

            @update editor # for spec tests and initial load for example

    # Public
    destroy: ->
        @subscriptions?.dispose()
        for marker in @markers
            marker.destroy()

    # Private
    update: (editor) ->
        decorate = (token) =>
            tableName = token.value.trim()

            # +1 -1 handle extra spaces.
            marker = editor.markBufferRange new Range(
                new Point(lineNum, tokenPos + 1),
                new Point(lineNum, tokenPos + token.value.length - 1)),
                type: 'qolor'
            @markers.push marker
            decoration = editor.decorateMarker marker,
                type: 'highlight'
                class: 'qolor-table'

        grammar = editor.getGrammar()
        unless grammar.name == 'SQL'
            return

        text = editor.getText()

        for line, lineNum in grammar.tokenizeLines(text)
            tokenPos = 0
            saveNext = false
            for token, tokenIndex in line
                if saveNext
                    saveNext = false # this is for same lines

                    decorate token

                if token.value in ['from', 'join']
                    saveNext = true
                else
                    saveNext = false
                tokenPos += token.value.length

module.exports = document.registerElement('qolor-view',
                                          prototype: QolorView.prototype,
                                          extends: 'div')
