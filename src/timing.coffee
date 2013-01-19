fs = require('fs')
_  = require('underscore')

args = process.argv.splice(2)
dat = fs.readFileSync(args[0]).toString().split('\n')
log = console.log

events = {}

_(dat).each (line) ->
  if line.length
    o = JSON.parse line
    events[o.message] = [] if not events[o.message]
    events[o.message].push(o.duration)

_(events).each (eventSet, event) ->
  avg = 0
  min = 1e9
  max = -1e9
  _(eventSet).each (duration) ->
    avg += duration
    min = duration if (duration < min)
    max = duration if (duration > max)
  avg /= eventSet.length
  log event, 'avg:',avg,'min:',min,'max:',max,'num',eventSet.length,'total time',eventSet.length * avg


