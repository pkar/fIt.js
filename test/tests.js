var L = console.log;

module('Utils');
var U = fIt.Utils;
test("extend", function() {
  var a = {a: 'a', b: 'b'};
  var b = {};
  var c = U.extend(b, a);
  deepEqual(c, a, 'extend');
  b = {c: 'c'};
  c = U.extend(b, a);
  notDeepEqual(c, a, 'extend');
});
test("each", function() {
  var y = [];
  U.each([1,2,3], function(item) {y.push(item);});
  deepEqual(y, [1,2,3], 'each');
});
test("max", function() {
  ok(U.max(-1, -3) == -1, 'max');
  ok(U.max(9, 5) == 9, 'max');
});
test("keys", function() {
  deepEqual(U.keys({}), [], 'empty keys');
  deepEqual(U.keys({a:'', b:''}), ['a', 'b'], 'empty keys');
});

module('Esoteric');
var E = fIt.Esoteric;
test("mapKeys", function() {
  keys = {
    '1': '',
    '2': 'abc',
    '3': 'def',
    '4': 'ghi',
    '5': 'jkl',
    '6': 'mno',
    '7': 'pqrs',
    '8': 'tuv',
    '9': 'wxyz',
  };
  deepEqual(E.mapKeys(keys, '1', 'recursive'), ['1'], '2');
  deepEqual(E.mapKeys(keys, '2', 'recursive'), ['a', 'b', 'c'], '2');
  deepEqual(E.mapKeys(keys, '23', 'recursive'), ['ad','ae','af','bd','be','bf','cd','ce','cf'], '23');
  notDeepEqual(E.mapKeys(keys, '32', 'recursive'), ['ad','ae','af','bd','be','bf','cd','ce','cf'], '32 not equal');
  deepEqual(E.mapKeys(keys, '$2', 'recursive'), ['$a', '$b', '$c'], '$2');
  var three = E.mapKeys(keys, '456', 'recursive');
  ok(three.length, 3, '456');
});

test("maxProfit", function() {
  m = E.maxProfit([2, 7, 1, 8, 2, 8, 4, 5, 0, 4, 9, 5]);
  deepEqual(m, [9, [8, 10]], '')
  m = E.maxProfit([0, 7, 1, 8, 2, 8, 4, 5, 9, 4, 9, 100]);
  deepEqual(m, [100, [0, 11]], '')
});

test("fibonacci", function() {
  var fib = [0,1,1,2,3,5,8,13,21,34,55,89,144];
  for(var i=0; i<fib.length; ++i) {
    ok(E.fibonacci(i, 'i') === fib[i], '0i'); 
    ok(E.fibonacci(i, 'r') === fib[i], '0r'); 
    ok(E.fibonacci(i, 'm') === fib[i], '0m'); 
  }
});

test("factorial", function() {
  ok(E.factorial(0) == 1, '0'); 
  ok(E.factorial(1) == 1, '1'); 
  ok(E.factorial(2) == 2, '2'); 
  ok(E.factorial(3) == 6, '3'); 
  ok(E.factorial(4) == 24, '4'); 

  ok(E.factorial(0, 'r') == 1, '0r'); 
  ok(E.factorial(1, 'r') == 1, '1r'); 
  ok(E.factorial(2, 'r') == 2, '2r'); 
  ok(E.factorial(3, 'r') == 6, '3r'); 
  ok(E.factorial(4, 'r') == 24, '4r'); 
});

test("pascalsTriangle", function() {
  res = E.pascalsTriangle(1);
  deepEqual(res, [[1]], 'Iterative 1');
  res = E.pascalsTriangle(2);
  deepEqual(res, [[1], [1,1]], 'Iterative 2');
  res = E.pascalsTriangle(3);
  deepEqual(res, [[1], [1,1], [1,2,1]], 'Iterative 3');
  res = E.pascalsTriangle(4);
  deepEqual(res, [[1], [1,1], [1,2,1], [1,3,3,1]], 'Iterative 4');
  res = E.pascalsTriangle(5);
  deepEqual(res, [[1], [1,1], [1,2,1], [1,3,3,1], [1,4,6,4,1]], 'Iterative 5');
  res = E.pascalsTriangle(6);
  deepEqual(res, [[1], [1,1], [1,2,1], [1,3,3,1], [1,4,6,4,1], [1,5,10,10,5,1]], 'Iterative 6');

});

