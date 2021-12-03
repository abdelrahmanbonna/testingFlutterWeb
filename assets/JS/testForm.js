
function testJs(){
  alert('Testing Js from Dart')
}

function printStars(length ){
  for (let index = 0; index < length; index++) {
    for (let i = 0; i < length; i++) {
      alert('*')
    }
    alert('\n')
  }

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