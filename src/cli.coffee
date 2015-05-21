# Dependencies
Command= (require 'commander').Command
Promise= require 'bluebird'

{stdin}= process
path= require 'path'
fs= require 'fs'

# Public
class CLI extends Command
  parse: (argv)->
    super argv

    new Promise (resolve)=>
      stdin.resume()
      stdin.setEncoding 'utf8'

      stdinData= ''
      stdin.on 'data',(chunk)-> stdinData+= chunk
      stdin.on 'end',->
        resolve stdinData

      help= setTimeout (->resolve null),500
      stdin.on 'data',-> clearTimeout help

    .then (stdinData)=>
      stdin.pause()

      if @args.length
        filePath= path.resolve process.cwd(),@args.shift()
        stdinData?= fs.readFileSync filePath,'utf8'

      stdinData

module.exports= CLI