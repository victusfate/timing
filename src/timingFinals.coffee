fs = require('fs')
_  = require('underscore')

log = console.log

args = process.argv.splice(2)
log 'args',args
dat = fs.readFileSync(args[0]).toString().split('\n')
log dat

events = {}


_(dat).each (line) ->
  if line.length
    try 
      o = JSON.parse line
    
    catch err 
      
    if o and o.__ms and o.montage_id
      events['fullTime'] = [] if not events['fullTime']
      events['fullTime'].push { montage: o.montage_id, time: o.__ms }

log 'frames'
_(events['fullTime']).each (v) ->
    log v.montage, v.time
