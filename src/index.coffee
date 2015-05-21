# Dependencies
htmlparser2= require 'cheerio/node_modules/htmlparser2'
cheerio= require 'cheerio'
htmlBeautify= require('js-beautify').html

CLI= require './cli'

# Public
class JSONML extends CLI
  constructor: (argv)->
    super argv

    @version (require '../package').version
    @usage '<stdin / filename>'
    @option '-i, --indent <digit>','Space indentation',2

    @parse argv
    .then (data)=>
      return @help() unless data?

      if data[0] is '['
        console.log JSONML.stringify (JSON.parse data),null,~~@indent
      else
        console.log JSON.stringify (JSONML.parse data),null,~~@indent

      process.exit 0

  # Static
  @stringifyListMode: on
  @parse: (html,trim=yes)->
    html= html.outerHTML if html?.outerHTML

    nodes= htmlparser2.parseDOM html,{xmlMode:on}
    object= JSONML.parseElementList nodes,trim
    object

  @parseElementList: (nodes,trim=yes)->
    i= -1

    elementList= []
    for node in nodes
      element= JSONML.parseElement node,trim
      if typeof element is 'string'
        element= element.trim() if trim
        element= '' if '&nbsp;' if trim
        
      continue if element?.length is 0

      canConcat= typeof elementList[i] is 'string' and typeof element is 'string'
      if canConcat
        elementList[i]+= element
      else
        elementList.push element if element?
        i++

    elementList

  @parseElement: (node,trim=yes)->
    {name,attribs,children}= node

    switch node.type
      when 'tag'
        elementList= JSONML.parseElementList children,trim

        element= []
        element.push name if name?
        element.push attribs if Object.keys(attribs).length
        element.push child for child in elementList
        element
      when 'directive'
        '<'+node.data+'>'
      when 'comment'
        '<!--'+node.data+'-->'
      else
        node.data

  @stringify: (object,replacer,indent)->
    html= ''
    if JSONML.stringifyListMode
      html+= JSONML.stringifyElement element,replacer for element in object
    else
      html+= JSONML.stringifyElement object,replacer

    if indent>0
      html= htmlBeautify html,
        indent_size: indent
        unformatted: ['code','pre','em','strong','span']
      html= html
        .replace /^\s*/g, ''
        .replace /(\r\n|\n){2,}/g,'\n'

    html

  @stringifyElement: (element,replacer)->
    if typeof element is 'string'
      node= element
    else
      unless typeof element[0] is 'string'
        throw new TypeError 'Invalid tagName "'+element[0]+'"'

      name= element.shift()
      attributes= element.shift() if element[0]?.toString() is '[object Object]'
      elementList= element ? []

      node= cheerio '<'+name+'/>'
      node.attr attributes if attributes?
      node.append JSONML.stringifyElement list for list,i in elementList

    node= replacer node if replacer?

    node

module.exports= JSONML