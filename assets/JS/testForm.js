
function testJs(){
  alert('Testing Js from Dart')
}

function printStars(length ){
  var strng = ''
  for (let index = 0; index <= length; index++) {
    for (let i = index; i >0; i--) {
      strng +='*'
    }
    strng +='\n'
  }
  return strng
}

function getValue(){
  var sum = 0;
  if(arguments!=null)
    for (let index = 0; index < arguments.length; index++) {
       sum += arguments[index];
    }
   return sum;
}

testJs()