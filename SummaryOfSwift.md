# Summary of Swift

## weak and unowned
- weak : target can be nil.
- unowned : Use this when you sure that the target will never be nil.

## protocol
- Self : 
	- Instance conforms the protocol.
	- this is not documented well even though in Apple's document.
- Protocol Composition
	- You can list as many porotocols as you need to, separating them by '&'
	
```
func doSomething(target: ProtocolA & ProtocolB) { ... }
```
- If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension.

```
extension SomeType: TheProtocol {}
```


# CocoaPod
- [The Elegant Solution To Installing The Same Pod In Multiple Targets](https://www.natashatherobot.com/cocoapods-installing-same-pod-multiple-targets/)


## Types

### Usage of data types
- Use Int for usual usage.
- Use Float for location or size of image.
- '=' does not return any value. 

```swift
a = b = c // NG
if a = 1 { ... // Error
```
- Use 'typealias' to give a different name for a data type.  

```swift
type alias SInteger = Int32 // alias is the one on left side.
```
- Use namespace to distinguish types with same name. 

```swift
Foundation.fopen
```

##### Stride type  
*This has been changed in Swift 2.0. Please ignore this section.*

function for making a struct that can be used to define range in 'for - in' statement.

```swift
var st1 = stride(from:8, through:20, by:4)  // This is using 'through'.
for i in sty { print(" \(i)") } // Print 8 12 16 20.

var st2 = stride(from:8, to:20, by:4) // This is using 'to'.
for in in sty { print(" \(i)" } // Print 8 12 16 
```

##### Array 

- Only one type of data can be included in an Array.
- Array is a value type.
- Operator '==' is True when the number and order of elements in both Arrays are identical.
- Methods of the Array
	- filter(_ : ) -> [T]  Parameter is a closure.  Execute the closure for each element in the array and return a new array with only elements those fulfil the condition.
	- map \<U> ( _ :) -> [U] Parameter is a closure. Execute the closure for each elements in the array and make a new array with the results.
	- reduce\<U>( _ : U, _ :(U, T) -> U ) -> U  Parameter are default value and closure. Execute the closure with the default value and the first element in the array, and then execute the closure with the result of the first execution and next element as parameters. And continue the execution for the last elements.  
- Use optional type to adding 'nil' to array.

```swift
var sparse : [Int?] = [1,2,nil,4,nil]
```

##### dictionary

- How to define;

```swift
var d : [String : Int]

var e = [String : Int]()

var d : [String : Int] = [:]
```

- How to use;

```swift
var d = ["Swift":2014, "Objective-C", 1983]
if let y = d["ruby"] { // return value is optional because the key can contain nil value or is not exist.
	println(y)
}

for (key, value) in d { // Getting tuple of key and value from dictionary.
	println("\(key) and \(value)"
}

// Above is same as below.
for t in d {
	println("\(t.0) and \(t.1)"
}

d["Swift"] = nil // Deleting the key. Now the d is ["Objective-C" : 1983].
```

- '==' is true if two dictionaries have same keys and values.

### Control statements

#### for 

```swift
A ..<B  // A <= x < B (Half open interval)
A ... B // A <= x <= B (closed interval)
```

#### switch

- 'break' is no more needed. Swift stops execution after execution of matching case.
- If you want to execute next case, use 'fallthrough'.

#### Labeled loop
Add level for each loop so that you can control the flow of execution of loop statements. 

```swift
loop1: while some condition { // 1
	loop2: while other condition { // 2
		while more condition { 
			break loop1 // goto 4
			continue loop1 // goto 1
			break loop2 // goto 3
			continue loop2 // goto 2
		}
	} // 3
} // 4
```
### assert
- assert will be ignored in release build. You can set -Ounchecked as an option for compile to ignore assert. 
- If the condition of assert is fail, it will stops the execution of the app and log the message.
 
### How to Comment 
Below are documentation comments.

```swift
/** 
Some comments.
- bullet point type 1
+ bullet point type 2
* bullet point type 3

:param:
:returns:
 */

 Some code comes here.
 
/// A line of comment to be added to document.
```

### Value types vs Reference types
- Value Types (Pass by Value)
	- Struct
	- Enum
	- tuple
	- Array
	- Dictionary
	- String
- Reference Types (Pass by Reference)
	- Class 
	- Closure

Use Int for usual cases. If you want more detailed data, use Float or Double. Float is suitable for specifying location or size of images.

Use Struct for expression of related data, Class for structure and or Role of processes of App.
	
## Tuple
- When to Use tuple;
	- for small chunk of structured data those are not big enough to make a struct or a class. Do not make a complex data structure with tuple.
	- Return more than one value from function or method.
	- **If function is not declared to return value, it returns empty tuple, (). () is another expression of 'Void' type.**
	- Tuple with one value is same as just the value.
	- Dictionary in Swift cannot contain different types of values but you can do it with Tuple.

- How to use.

```swift
let catPhoto = ("Cat.png", 1024, 768) // Define tuple for an image file.
println(catPhoto.0) // Can access to data in tuple by using index number starting from 0.

let (file, width, height) = catPhoto // Can set each element of tuple to variable or constant.

let (fileName, _, _) = catPhoto // Can ignore some values in tuple and use file name only. 

let pic = ("dog.png", (1024, 768)) // tuple can include tuple.
print(pic.1.0) // Print 1024.


let photo = (file:"tiger.png", width:1024, height:768) // Tuple can have keyword.
print(photo.width) // Print 1024

(1,2) == (1,2) // Error! No operator to compare two tuples. 

let day = (1,2)
switch day {
	case (1,1) : println("The first day of the year.")
	case (5, 2...6) : println("Holidays.")
	case (12, let d) : println("My Birthday.") // define constant with an element of tuple.
	case (8, _) : println("Summer vacations.") // Ignore date.
	case (let m, let d) where dayOfWeek(m, d) == 0 : println("\(m) / \(d) is Monday.")
	default : println("default.")
} // Keyword of tuple will be ignored in Switch statement.
```



## Enumeration
- **Consider enum as tag for a bunch of data. You can use different data with a common tag by declaring them as members of an enum.**
- **Use enum for defining data or using data as a group. Not for saving or modifying data.** 
	- But, can modifying information in self. 
- Enumeration in Swift can have;
	- Computed property
	- Method
	- Type property
	- Type method.
	- initializer : init?(rawValue:) is automatically created and can be redefined.
- Enumeration in Swift can not have;
	- Stored property
- Members in Enumeration cannot have same value.
- Method in Enumeration **should be used to handle members of the Enumeration only**.
- Method with keyword 'mutating' can change the value in a variable **by setting different value to 'self'**. 
	- See below sample code. calling turnBack method will set different value to variable.


```swift
enum Direction : Int {
    // Members
    case Up = 0, Down, Right, Left
    
    static var defaultDirection = Direction.Left
    
    init() {
        self = Direction.defaultDirection
    }
    // Computed property
    var horizontal: Bool {
        switch self {
            case .Right, .Left: return true
            default: return false
        }
    }
    
    mutating func turnBack() {
        self = Direction(rawValue:((self.rawValue + 2) % 4))!
    }
}

var a = Direction.Right
let i = a.rawValue // i = 2 (Int)
let k = Direction.Down.rawValue // k = 1 (Int)
a.turnBack() // Now a has different value.
let j = a.rawValue

var e = Direction() // This line of code does not work in Xcode 6.3 Beta and I don't know why.
let f = Direction.defaultDirection.rawValue 
let g = e.rawValue
println("aaa \(g)")
```

## Operator
- Each operator has a priority between 0 to 255. The higher number has higher priority.
- Prefix and Postfix operators does not have priority values. But there are orders; 
	- Postfix > Prefix > other operators 

### Defining new operator
- You can define new operator by yourself.
	- Declare the operator at top level not in a function or other data types. 

```swift
infix operator operator_name {
	precedence 100 // priority. Default value is 100. 
	associativity left // You can use one from left, right, and none. Default value is none.
}

prefix operator operator_name { }

postfix operator operator_name { }
```
- Sample code for declaring a binary operator.

```swift
inifix operator ~ {
	precedence 20
	associativity none
}

fun ~ (n:Int, w:Int) -> String { // the first argument 'n' is the left operand and 'w' is right operand.
	// any implementation
	return str
}
```
- Sample code for declaring a unary operator.

```swift
postfix operator % { } // Keyword postfix or prefix is required.

postfix fun % (n:Int) -> Double {
	return 0.01 * Double(n)
}

postfix operator % (n:Double) -> Double {
	return 0.01 * n
}
```

### Adding more functionality to existing operator
- You can;
	- adding supports for other data types
	- make unary operator to binary or ternary operator.  

### Postpone evaluation of argument
- You can postpone the evaluation of argument by using @autoclosure.

```swift
func skip (cond: Bool, arg:Int) {
	if !conf { println("value = \(arg)") }
}
	
skip (someCondition(1), highCost(1000)) 

// Evaluation of highCost takes long time and we want to avoid it. To do that, use @autoclosure.

func skip (con:Bool, arg:@autoclosure() -> Int) {
	if !cond { println("value = \(arg())") } // Evaluation will be executed when arg() is called.
}
```

## Class

- Not required to define parent class.
- All instance properties should have default values in order to omit initialiser of the class.


### Properties
- Use 'didSet' or 'willSet' to update related properties in the class.


### Function

- Function is the first class **DATA TYPE**.  
- 'closure' is function without name. 
- Functions without a defined return type return a special value of type Void. This is simply an empty tuple, in effect a tuple with zero elements, which can be written as ().
- If the tuple type to be returned from a function has the potential to have “no value” for the entire tuple, you can use an optional tuple return type to reflect the fact that the entire tuple can be nil. 
	- An optional tuple type such as (Int, Int)? is different from a tuple that contains optional types such as (Int?, Int?). With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
- You can write an external parameter name before the local parameter name it supports, separated by a space:. If you provide an external parameter name for a parameter, that external name must always be used when you call the function.

```swift
 func​ ​someFunction​(​externalParameterName​ ​localParameterName​: ​Int​) {
​    ​// function body goes here, and can use localParameterName
​    ​// to refer to the argument value for that parameter
​}
​
// Below is Example
func joinString(firstString s1:String, secondString s2:String ) -> String {
    println(s1 + s2)
    return s1 + s2
}

let aaa = joinString(firstString: "Hello", secondString: "World")
```
- Or, write the name once, and prefix the name with a hash symbol (#). This tells Swift to use that name as both the local parameter name and the external parameter name.

```swift
func joinStringSimplified(#firstString:String, #secondString:String ) -> String {
    println(firstString + secondString)
    return firstString + secondString
}

let bbb = joinStringSimplified(firstString: "Hi, ", secondString: "Swift.")
```

- Default value for parameter can be provided too. Be sure that parameters with default value should be located as last parameter so that user of the function can omit the parameter.
	- Swift provides an automatic external name for any parameter that has a default value. The automatic external name is the same as the local name. 

```swift
func joinStringwithDefaultValue(#firstString :String, #secondString: String = "Swift") -> String {
      	return firstString + secondString
}

let ccc = joinStringwithDefaultValue(firstString: "Hello, ", secondString: "Objective-C")
let ddd = joinStringwithDefaultValue(firstString: "Hi, ") // The second parameter is omitted.
```

- Parameters of functions are constants by default. If you try to change the value of a function parameter, the compiler will issue an error. If you need to change parameter in the body of function, use 'var' for the parameter.

```swift
func alignRight(var string: String, count: Int, pad: Character) {
	
}
```
- A variadic parameter accepts zero or more values of a specified type. A function may have only one variadic parameter and it should be placed as last parameter.

```swift
func​ ​arithmeticMean​(​numbers​: ​Double​...) -> ​Double​ {
    // numbers is an array of Double.
}
```
'_' is used for ignoring.

```swift
_ = myFunction() // Just ignore the return value from the function.

func compare(a:Int, b:Int, _:Bool) -> Bool { // Do not use the third parameter.
	return a > b
} 
```
Functions can be overloaded with;

- different number of parameters
- different data type of parameter
- different data type of return value
- different external parameter name

### Structure

Similar to Class but Structure is;

- value type data
- No inheritance
- Structure and processing is fixed before running.

Structure is referenced by only one place of code. If it is required to be referenced by more than one place, use class instead of structure.

Default initializer, structName(), can be used if all properties have default values and there is no initializer defined.

Memberwise initializer can be used if there is no initializer and all properties does not have default values.

```swift
var aDate = Date(year:1969, month:12, day:13)
```

Initializer has only name, init.
In the initializer, you can set a value for constant property *once*.  If you try to set value of constant property from different initializer more than once, it will be an error.

Add 'mutating' in front of func for method that modify any value in the struct. (No for instance method that modify value of type property.)

Two types of property ; Stored property and Computed property.

##### Computed property
- Always use 'var' because the value of the property can be changed by computation.
- Can have 'get' and or 'set' as getter and setter.
- 'newValue' is the default name of parameter for 'set'.  

##### Property Observer
- 'willSet' and 'didSet'.
- 'willSet' can use 'newValue' to refer a new value from parameter.
- 'didSet' can use 'oldValue' to refer an old value of the property.
 
##### subscript
- Allow to access to properties just like those are elements of an Array. 
- I don't see any specific needs for this.

### Optional
- Optional can have value 'nil'.<br>
- Default value of optional variable and constant is 'nil'.
- Use '!' for unwrapping optional value. If the value is 'nil', unwrapping causes runtime error. 
- Optional Binding :

```swift
let year : Int? = "2020".toInt()
if let y = year { // <-- Optional Binding. You can use 'var' instead of 'let'.
	// do something.
} else {
	// do something.
}
```
- nil coalescing operator :

```swift
(opv != nil) ? opv! : S
 // Above is same as below.
 opv ?? S
 
// Example:
var val =  str.toInt() ?? 0  // Return 0 if the value of str is nil or cannot be converted to Int.
```
 - Implicitly unwrapped optional : 
 	- Use when you make sure the value is not 'nil' after a certain point of code.
 	- It is programmer's responsibility to make sure the value is not 'nil'.
 	- Use '!' for declaring the data type.

 ```swift
 	let year : Int! = "2020".toInt()
 	println("\(year - 2015) is left"
 ```

- Failable initializer : 
	- In some cases, initializer of class or struct can fail to make an instance of it.
	-  This can happen with wrong value for initialiser's parameter such as file path or URL.
	- Use init? instead of init. Return 'nil' when the initializer fails. But do not return instance.

### extension
Replace of Category in Objective-C.

```swift
extension NSString {
    func toURL() -> NSURL {
        return NSURL.URLWithString(self);
    }
    ...
}
```

### methods
Method is a function associated in types such as Class, Structure, and Enumeration.

#### Class method and Class properties
Class method and Class properties are called as type methods and type properties in Swift.
**But, type properties are not supported yet.**


```swift
class Foo {
    var name: String?           // instance property
    class var all: Foo[] = []   // type property NOT YET SUPPORTED
    class var comp: Int {       // computed type property
        return 42
    }

    class func alert() {        // type method
        println("There are \(all.count) foos")
    }
}

Foo.alert()
``` 

#### didSet and willSet 

```swift
class​ ​TriangleAndSquare​ {
​    ​var​ ​triangle​: ​EquilateralTriangle​ {
​        ​willSet​ {
​            ​square​.​sideLength​ = ​newValue​.​sideLength
​        }
​    }
​    ​var​ ​square​: ​Square​ {
​        ​willSet​ {
​            ​triangle​.​sideLength​ = ​newValue​.​sideLength
​        }
​    }
​    ​init​(​size​: ​Double​, ​name​: ​String​) {
​        ​square​ = ​Square​(​sideLength​: ​size​, ​name​: ​name​)
​        ​triangle​ = ​EquilateralTriangle​(​sideLength​: ​size​, ​name​: ​name​)
​    }
​}
```

## Comparison with Objective-C

| Objective-C | Swift |
|:---- |:---- |
| Category | extension |
| NA| tuple |
| class method  (ex: + methodName)| Type method (ex: static methodName)|
| class property (ex: + propertyName)| Type property (ex: static propertyName)| 
| Delegation is delegate process of some method to other class.   | Delegation is calling other initialiser to complete instantiation of a class. |

- In Swift, '=' does not return any value while Objective-C returns the signed value.

## Tips
- [Use enums instead of Booleans.](http://www.objc.io/snippets/12.html?utm_campaign=This_Week_in_Swift_23&utm_medium=email&utm_source=This%2BWeek%2Bin%2BSwift)
-  Usage of each Types

| Type | When to use | Example |
|:---|:---|:---|
| tuple| - Use tuple when you want to make a group of data with related data but it is too simple to define as a struct or a class.<br>- Use as return value of function or computed property.  | file name and the length of the file;<br> ```swift let fileInfo = ("aaa.txt", 360) ```| 
| enum | - Tagging for distinguishing related data. <br>- Tagging different types of data for ease of using.<br> - Goal is not storing or change data, but distinguish them or use them in all together. | Tickets: OneDayTicket, FreeTicket, Prepaid |
| struct | |
|class| |

---

## Before Start

## How to use
This file is generated by using Playground. Refer below links to know how to generate playground from this markdown file. 

[https://github.com/jas/playground](https://github.com/jas/playground)

For quick reference, below is command-line Usage.


    Usage: playground <paths>... [options]

    paths     Markdown files(s), or directory containing Markdown files,
              from which to build the Playground(s).

              The Markdown file(s) must have one of these common Markdown
              file extensions: .md .markdown .mdown .mkdn .mkd

    Options:

       -d, --destination   Directory in which to output the Playground(s);
                           defaults to the current working directory

       -p, --platform      Specifies which platform's frameworks can be imported
                       in the Playground(s); only one platform can be choosen
                       [options: ios, osx] [default: osx]

       -n, --noreset       Don't allow edited code to be reset from the
                       "Editor → Reset Playground" menu in Xcode

       -s, --stylesheet    Path to custom stylesheet

       -v, --version       Print "playground" version and exit
 

  git
