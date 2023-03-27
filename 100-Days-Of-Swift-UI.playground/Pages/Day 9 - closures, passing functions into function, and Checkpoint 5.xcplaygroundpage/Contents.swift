import Cocoa

// Closures
func greetUser() {
  print("Hi there!")
}

greetUser()

// this creates a copy of the function then calls the copy.
var greetCopy = greetUser
// When youre copying a function you won't include the parentheses after is. var greetCopy = greetUser NOT greetUser(). if you use the parentheses then you are calling the funtion and assigning the return to something else.
greetCopy()

// closure expression: a chunk of code we can pass around and call whenever we want.
// you can assign functionality directly to a constant or variable
/*
 let sayHello = {
 print("Hi there!")
 }
 
 sayHello()
 */
// if you want the closure to accept parameters - put the information inside of the braces:
 
let sayHello = { (name: String) -> String in
  "Hi \(name)!"
}

sayHello("Steph")

// in is used to mark the end of parameters and return type - everything after in is the body of the closure.

// greetUser() takes no parameters, returns no value, and does not throw errors. If we were to write it as a type annotation for greetCopy, it would look like:
// var greetCopy: () -> Void = greetUser

// the empty parentheses markes a function that takes no parameters.
// the arrow means we are about to declare the return type for the function
// Void means "nothing" - the function returns nothing. Can also be written as () but it can be confused with an empty parameter list

//every functions type depends on the data it recieves and sends back. the names of the data it recieves is not part of the functions type.

func getUserData(for id: Int) -> String {
  if id == 1989 {
    return "Taylor Swift"
  } else {
    return "Anonymous"
  }
}

// the function accepts and int and returns a string.
let data: (Int) -> String = getUserData
// when we take a copy of the function the type of function doesnt include the for parameter name. so when we call the copy we use data(1989) instead of data(for: 1989)
let user = data(1989)
print(user)

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)


// sorted() allows us to pass in a custom sorting function to control certain scenarios.
// This function must accept two strings, and return true if the first string should be sorted before the second, or false if the first string should be sorted after the second.

func captainFirstSorted(name1: String, name2: String) -> Bool {
  // if the first name is Suzannr - return true so name1 is sorted before name2.
  if name1 == "Suzanne" {
    return true
  // if name2 is Suzanne return false so name1 is sorted after name2.
  } else if name2 == "Suzanne" {
    return false
  }
  
  // if neither name is Suzanne - just use a normal alphabetical sort
  return name1 < name2
}

//let captainFirstTeam = team.sorted(by: captainFirstSorted)
//  print(captainFirstTeam)

// we can create closures as anonymous functions, storing them inside constants and variables - see sayHello example

// we can also pass functions into other functions like captainFirstSorted() into sorted()

// start a new closure: write an open brace, list its parameters and return type, write in, then put our standard function code.

// calling sorted() like above.
// instead of passing in a function, we're using a closure - everything from opening brace after by: to the closing brace is part of the closure.

//let captainFirstTeam = team.sorted(by: {(name1: String, name2: String) -> Bool in
//  if name1 == "Suzanne" {
//    return true
//  } else if name2 == "Suzanne" {
//    return false
//  }
//
//  return name1 < name2
//})

//----------------------
// How to use trailing closures and shorthand syntax

// sorted() can accept any kind of function to do custom sorting, with one rule: that function must accept two items from the array in question (that’s two strings here), and return a Boolean set to true if the first string should be sorted before the second.

// in our example, We don’t need to specify the types of our two parameters because they must be strings, and we don’t need to specify a return type because it must be a Boolean. so we rewrite to (by: {name1, name2 in })
  // when one function accepts another as its parameter - that is called trailing closure syntax. we remove the by: (previously written as (by: {name1, name2 in }) ) - change to team.sorted { name1, name2 in
  // shorthand syntax - automatically provides parameter names.
  // with this syntax we dont need to write name1, name2 in - we can swap it for Swift's specially named values $0 and $1 (first and second string respectively)
let captainFirstTeam = team.sorted {
  if $0 == "Suzanne" {
    return true
  } else if $1 == "Suzanne" {
    return false
  }
  
  return $0 < $1
}

// above is not a great example to use shorthand syntax.Below is a better use - if we wanted to do a reverse sort.
// since there is 1 line - we can remove the return.
let reverseTeam = team.sorted{$0 > $1}

// When to use shorthand syntax:
/*
- closure code is long
- $0 and friends are used more than once each
- you get three or more parameters ($2, $3, etc.)
*/

//ADDITIONAL CLOSURE EXAMPLES
// filter() - lets us run code on every item in an array and returns a new array with the items that return true from the function.
// ex. we can find team players whose name begins with T:
let tOnly = team.filter{$0.hasPrefix("T")}
print(tOnly)

// map() - transforms every item in the array using some code of our choosing then sends a new array of transformed items.
let uppercaseTeam = team.map{ $0.uppercased() }
print(uppercaseTeam)
// this will print an uppercased version of all the team members and create a new array.
// Tip: When working with map(), the type you return doesn’t have to be the same as the type you started with – you could convert an array of integers to an array of strings, for example.

// examples of when to use closures:
/*
 When you create a list of data on the screen, SwiftUI will ask you to provide a function that accepts one item from the list and converts it something it can display on-screen.
 
 When you create a button, SwiftUI will ask you to provide one function to execute when the button is pressed, and another to generate the contents of the button – a picture, or some text, and so on.
 
 Even just putting stacking pieces of text vertically is done using a closure.

*/

//----------------------
// How to accept functions as parameters

// 
