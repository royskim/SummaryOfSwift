# Summary of Swift

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
type alias SInteger = Int32 // alias is left side.
```
- Use namespace to distinguish types with same name. 

```swift
Foundation.fopen
```

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
	
## Class
- Not required to define parent class.
- All instance properties should have default values in order to omit initialiser of the class.
- 

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
 

