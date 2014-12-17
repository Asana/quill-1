describe('Formatter', ->
  beforeEach( ->
    resetContainer()
    @container = $('#test-container').html('').get(0)
  )

  tests =
    tag:
      format: new Quill.Formatter.Format(
        tag: 'B'
      )
      existing: '<b>Text</b>'
      missing: 'Text'
      value: true
    style:
      format: new Quill.Formatter.Format(
        style: 'color'
      )
      existing: '<span style="color: blue;">Text</span>'
      missing: 'Text'
      value: 'blue'
    attribute:
      format: new Quill.Formatter.Format(
        attribute: 'data-format'
      )
      existing: '<span data-format="attribute">Text</a>'
      missing: 'Text'
      value: 'attribute'
    class:
      format: new Quill.Formatter.Format(
        class: 'author-'
      )
      existing: '<span class="author-jason">Text</span>'
      missing: 'Text'
      value: 'jason'
    line:
      format: new Quill.Formatter.Format(
        style: 'text-align'
      , Quill.Formatter.types.LINE)
      existing: '<div style="text-align: right;">Text</div>'
      missing: '<div>Text</div>'
      value: 'right'

  describe('value()', ->
    _.each(tests, (test, name) ->
      it("#{name} existing", ->
        @container.innerHTML = test.existing
        expect(test.format.value(@container.firstChild)).toEqual(test.value)
      )

      it("#{name} missing", ->
        @container.innerHTML = test.missing
        expect(test.format.value(@container.firstChild)).toBe(undefined)
      )
    )

    # it('default', ->
    #   @container.innerHTML = '<span style="font-size: 13px;">Text</span>'
    #   expect(Quill.Formatter.value(Quill.Formatter.formats.COLOR, @container.firstChild)).toBe(undefined)
    # )

    # it('bullets', ->
    #   @container.innerHTML = '<ul><li>One</li><li>Two</li><li>Three</li></ul>'
    #   li = @container.firstChild.childNodes[1]
    #   expect(Quill.Formatter.value(Quill.Formatter.formats.BULLET, li)).toBe(true)
    # )
  )

  describe('add()', ->
    _.each(tests, (test, name) ->
      it("#{name} add value", ->
        @container.innerHTML = test.missing
        test.format.add(@container.firstChild, test.value)
        expect(@container).toEqualHTML(test.added or test.existing)
      )

      it("#{name} add value to exisitng", ->
        @container.innerHTML = test.existing
        test.format.add(@container.firstChild, test.value)
        expect(@container).toEqualHTML(test.existing)
      )

      it("#{name} add falsy value to existing", ->
        @container.innerHTML = test.existing
        test.format.add(@container.firstChild, false)
        expect(@container).toEqualHTML(test.removed or test.missing)
      )

      it("#{name} add falsy value to missing", ->
        @container.innerHTML = test.missing
        test.format.add(@container.firstChild, false)
        expect(@container).toEqualHTML(test.missing)
      )
    )

    # it('change value', ->
    #   @container.innerHTML = '<span style="color: blue;">Text</span>'
    #   Quill.Formatter.add(Quill.Formatter.formats.COLOR, @container.firstChild, 'red')
    #   expect(@container).toEqualHTML('<span style="color: red;">Text</span>')
    # )

    # it('default value', ->
    #   @container.innerHTML = '<span>Text</span>'
    #   Quill.Formatter.add(Quill.Formatter.formats.SIZE, @container.firstChild, Quill.Formatter.formats.SIZE.default)
    #   expect(@container).toEqualHTML('<span>Text</span>')
    # )

    # it('text node tag', ->
    #   @container.innerHTML = 'Text'
    #   Quill.Formatter.add(Quill.Formatter.formats.BOLD, @container.firstChild, true)
    #   expect(@container).toEqualHTML('<b>Text</b>')
    # )

    # it('text node style', ->
    #   @container.innerHTML = 'Text'
    #   Quill.Formatter.add(Quill.Formatter.formats.SIZE, @container.firstChild, '18px')
    #   expect(@container).toEqualHTML('<span style="font-size: 18px;">Text</span>')
    # )

    # it('class over existing', ->
    #   @container.innerHTML = '<span class="author-argo">Text</span>'
    #   Quill.Formatter.add({ class: 'author-' }, @container.firstChild, 'jason')
    #   expect(@container).toEqualHTML('<span class="author-jason">Text</span>')
    # )

    # it('bullets', ->
    #   @container.innerHTML = '<ul><li>One</li></ul><div>Two</div><ul><li>Three</li></ul>'
    #   Quill.Formatter.add(Quill.Formatter.formats.BULLET, @container.childNodes[1], true)
    #   expect(@container).toEqualHTML('<ul><li>One</li><li>Two</li><li>Three</li></ul>')
    # )
  )

  describe('remove()', ->
    _.each(tests, (test, name) ->
      it("#{name} existing", ->
        @container.innerHTML = test.existing
        test.format.remove(@container.firstChild)
        expect(@container).toEqualHTML(test.removed or test.missing)
      )

      it("#{name} missing", ->
        @container.innerHTML = test.missing
        test.format.remove(@container.firstChild)
        expect(@container).toEqualHTML(test.missing)
      )
    )

    # it('line format with parentTag', ->
    #   @container.innerHTML = '<ul><li>One</li><li>Two</li><li>Three</li></ul>'
    #   li = @container.firstChild.childNodes[1]
    #   Quill.Formatter.remove(Quill.Formatter.formats.BULLET, li)
    #   expect(@container).toEqualHTML('<ul><li>One</li></ul><div>Two</div><ul><li>Three</li></ul>')
    # )

    # it('line format without parentTag', ->
    #   @container.innerHTML = '<div>One</div><h1>Two</h1><div>Three</div>'
    #   line = @container.childNodes[1]
    #   Quill.Formatter.remove({ type: Quill.Formatter.types.LINE, tag: 'H1' }, line)
    #   expect(@container).toEqualHTML('<div>One</div><div>Two</div><div>Three</div>')
    # )
  )
)
