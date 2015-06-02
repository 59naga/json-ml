# Dependencies
JsonML= require '../src'

cheerio= require 'cheerio'

fs= require 'fs'

# Environment
xml= fs.readFileSync __dirname+'/fixtures/svg.xhtml','utf8'
xmlJson= require './fixtures/svg'
html= fs.readFileSync __dirname+'/fixtures/foo.html','utf8'

# Spec
describe 'API',->
  describe 'on: stringifyListMode',->
    beforeAll ->
      JsonML.stringifyListMode= true

    describe 'parse',->
      it 'ballet elements',->
        expect(JsonML.parse xml).toEqual xmlJson
      it 'has textContent',->
        object= JsonML.parse '<foo bar="baz"><beep>boop</beep></foo>'

        expect(object).toEqual [['foo',{bar:'baz'},['beep','boop']]]

    describe 'stringify',->
      it 'stringify',->
        expect(JsonML.stringifyListMode).toBe true
        expect(JsonML.stringify xmlJson,null,2).toEqual xml

  # Grammar (BNF) via http://www.jsonml.org/
  describe 'off: JsonML.stringifyListMode',->
    beforeAll ->
      JsonML.stringifyListMode= false

    describe 'stringify',->
      it 'Plain text',->
        fixture= 'textNode'

        element= JsonML.stringify fixture
        expect(element).toBe 'textNode'

      it 'Tag',->
        fixture= ['ul']

        element= JsonML.stringify fixture
        expect(element).toBe '<ul></ul>'

      it 'Attribute',->
        fixture= ['ul',{id:'toc'}]

        element= JsonML.stringify fixture
        expect(element).toBe '<ul id="toc"></ul>'

      it 'Attribute List',->
        fixture= ['ul',{id:'toc',class:'header'}]

        element= JsonML.stringify fixture
        expect(element).toBe '<ul id="toc" class="header"></ul>'

      it 'Mixin',->
        fixture= ['ui',{id:'toc'},['li'],'li',['li']]

        element= JsonML.stringify fixture
        expect(element).toBe '<ui id="toc"><li></li>li<li></li></ui>'

      it 'title.texContent',->
        fixture= [
          "meta"
          {
            "charset": "UTF-8"
          }
          [
            "title"
            "http://www.jsonml.org/"
          ]
        ]

        element= JsonML.stringify fixture
        expect(element).toBe '<meta charset="UTF-8"><title>http://www.jsonml.org/</title>'

  describe 'Issues',->
    it '#1',->
      expect(-> JsonML.parse html).not.toThrow() 
