
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
