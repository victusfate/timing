fs = require('fs')
_  = require('underscore')

args = process.argv.splice(2)
dat = fs.readFileSync(args[0]).toString().split('\n')
log = console.log

events = {}

_(dat).each (line) ->
  if line.length
    try 
      o = JSON.parse line
    
    catch err 
      
    if o and o.message
      m = o.message.match(/Finished rendering and writing all (\d+) frames/ )
      if m
        msplit = o.message.split('Finished rendering and writing all')
        # log m[1]
        events['fullTime'] = [] if not events['fullTime']
        events['fullTime'].push { frames: m[1], time: o.__ms }

log 'frames'
_(events['fullTime']).each (v) ->
    log v.frames

log 'times'
_(events['fullTime']).each (v) ->
    log v.time    