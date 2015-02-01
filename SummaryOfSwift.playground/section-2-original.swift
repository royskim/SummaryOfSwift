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
