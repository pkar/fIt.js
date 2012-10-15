###
fIt.js 0.000001
(c) yeah
fIt can be distributed, dissected, and dismantled. It cannot be used though.
###

self = this
prefIt = self.fIt # For no-conflict

###
Reference to fIt for later use
###
fIt = (obj) ->
  if obj instanceof fIt
    return obj
  if not (this instanceof fIt)
    return new fIt(obj)
  this._wrapped = obj

###
Export for Node.js when on server, or assign to window for browser
###
if typeof exports isnt 'undefined'
  if typeof module isnt 'undefined' and module.exports
    exports = module.exports = fIt
  exports.fIt = fIt
else
  self.fIt = fIt

###
Version
###
fIt.VERSION = '0.01'
F = fIt # shortcut

###
Define some useful utility shortcuts
###
Utils = F.Utils = {}
###
Extend object a with properties of object b
###
Utils.extend = (a, b) ->
  for key, val of b
    if val is undefined
      delete a[key]
    else if (val isnt "constructor") or (a isnt window)
      a[key] = val
  return a

###
Derived from _.each
###
Utils.nativeForEach = Array.prototype.forEach
Utils.break = {}
Utils.each = (obj, iterator, context) ->
  if obj is null
    return
  if this.nativeForEach and obj.forEach is this.nativeForEach
    obj.forEach(iterator, context)
  else if obj.length is +obj.length
    for item, i in obj
      if (iterator.call(context, obj[i], obj) is Utils.break)
        return
  else
    for key, val of obj
      if (iterator.call(context, obj[key], key, obj) is Utils.break)
        return
###
Get an objects keys.
###
Utils.keys = (obj) ->
  if obj.keys
    return obj.keys
  (key for key, val of obj)

###
Mathematical version of max without comparisons
Only works on 32 bit numbers. Basically useless.
You know what works, Math.max, try it.
###
Utils.max = (a, b) ->
  #`a - ((a-b) & ((a-b)>>31))`
  c = a - b # Check if c is negative using twos complement highest bit
  k = `(c>>31) & 0x1` # shift bits to get highest bit, use 64 for 64bit
  a - k*c

###
A collection of esoteric junk
###

E = F.Esoteric = {}
###
Map permutations of keys with their letters
For instance, on a phone number pad, digits map to letters
2 -> [a, b, c]
23 -> [ad, ae, af, bd, be, bf, cd, ce, cf]
###
E.mapKeys = (keys, chars, type="iterative") ->
  if type is 'iterative'
    console
  else
    ret = []
    if chars.length < 1
      return ['']
    first = chars[0]
    rest = chars[1..]
    letters = keys[first]
    if not letters
      for y in this.mapKeys(keys, rest, 'recursive')
        ret.push first+y
    else
      for letter in keys[first]
        for y in this.mapKeys(keys, rest, 'recursive')
          ret.push letter+y
    ret

###
Given an array representing integer values over time, calculate
the maximum single sell profit, assuming that you may select 
at most once and deselect at most once over time.

For example, given the values

2, 7, 1, 8, 2, 8, 4, 5, 0, 4, 9, 5

The max profit is 9, by selecting at 1 deselecting when 9
Therefore the return values are (8, [8, 10])
###
E.maxProfit = (values) ->
  if not values
    return values
  if values.length is 1
    return [values[0], [0, 0]]

  min = values[0]
  profit = 0
  lowHigh = [0, 0]

  for val, i in values
    if val < min
      min = val
      lowHigh[0] = i

    if val - min > profit
      profit = val - min
      lowHigh[1] = i

  return [profit, lowHigh]

###
F(n) = F(n-1) + F(n-2)
###
E.fibonacci = (n, type='i') ->
  switch type
    when 'i' #iterative
      if n < 2
        return n
      a = 0
      b = 1
      for i in [1..n]
        c = a + b
        a = b
        b = c
      return a
    when 'r' #recursive
      fib = (f) ->
        if f < 2
          return f
        return fib(f-1) + fib(f-2)
      fib(n)
    when 'm' #memoization
      memo =
        0: 0
        1: 1
      fib = (f) ->
        if f > 1
          if f not in Utils.keys(memo)
            memo[f] = fib(f - 1) + fib(f - 2)
        return memo[f]
      fib(n)

###
Product of all positive integers less than or equal to n
###
E.factorial = (n, type='i') ->
  switch type
    when 'i' #iterative
      if n < 2
        return 1
      fact = 1
      for i in [1..n]
        fact = fact * i
      fact
    when 'r' #recursive
      fact = (f) ->
        if f < 2
          return 1
        return fact(f-1) * f
      fact(n)

###
In mathematics, Pascal's triangle is a triangular array of the 
binomial coefficients. Have I ever needed to know this? Never.
That's why it's here, in recursive and iterative forms, wow.
Is there a use for it? Maybe, look at chess.
###
E.pascalsTriangle = (n, type='i') ->
  switch type
    when 'i' #iterative
      res = []
      l = [1]
      res.push l
      if n > 1
        for i in [1..n-1]
          row = [1]
          for j in [0..l.length - 1]
            if l[j + 1]
              row.push(l[j] + l[j + 1])
          row.push 1
          l = row
          res.push l
      res

