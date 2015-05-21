# Dependencies
JSONML= require '../src'

fs= require 'fs'

# Environment
xml= fs.readFileSync __dirname+'/fixtures/svg.xhtml','utf8'
xmlJson= require './fixtures/svg'

# Spec
describe 'API',->
  describe 'JSONML.stringifyListMode= true',->
    it 'parse',->
      expect(JSONML.parse xml).toEqual xmlJson

    it 'stringify',->
      expect(JSONML.stringify xmlJson,null,2).toEqual xml

  # Grammar (BNF) via http://www.jsonml.org/
  describe 'JSONML.stringifyListMode= false',->
    beforeAll ->
      JSONML.stringifyListMode= false
    afterAll ->
      JSONML.stringifyListMode= true

    it 'Plain text',->
      fixture= 'textNode'

      element= JSONML.stringify fixture
      expect(element).toBe 'textNode'

    it 'Tag',->
      fixture= ['ul']

      element= JSONML.stringify fixture
      expect(element).toBe '<ul></ul>'

    it 'Attribute',->
      fixture= ['ul',{id:'toc'}]

      element= JSONML.stringify fixture
      expect(element).toBe '<ul id="toc"></ul>'

    it 'Attribute List',->
      fixture= ['ul',{id:'toc',class:'header'}]

      element= JSONML.stringify fixture
      expect(element).toBe '<ul id="toc" class="header"></ul>'

    it 'Mixin',->
      fixture= ['ui',{id:'toc'},['li'],'li',['li']]

      element= JSONML.stringify fixture
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

      element= JSONML.stringify fixture
      expect(element).toBe '<meta charset="UTF-8"><title>http://www.jsonml.org/</title>'
