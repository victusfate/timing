fs = require('fs')
_  = require('underscore')

args = process.argv.splice(2)
dat = fs.readFileSync(args[0]).toString().split('\n')
log = console.log

events = {}

_(dat).each (line) ->
    if line.length
        line = '{' + line.split(/\{(.+)?/)[1]
        try 
            o = JSON.parse line
        
        catch err
            log err 
            
        if o and o.action
            m = o.action.match(/Scene/)
            if m
                events['time'] = [] if not events['time']
                events['time'].push { time: o.__ms }

log 'times'

computeMean = (aObjects) ->
    sum = 0
    _(aObjects).each (v) ->
        sum += v.time
    sum/aObjects.length

log 'avg',computeMean(events['time'])/1000, 'n',events['time'].length