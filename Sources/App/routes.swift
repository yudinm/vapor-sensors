import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
//    app.get { req in
//        return "It works!"
//    }
//
//    app.get("hello") { req -> String in
//        return "Hello, world!"
//    }
//
//    try app.register(collection: TodoController())
    let sensorsController = SensorsController()
    app.get("sensors", use: sensorsController.json)
    app.post("sensors", use: sensorsController.create)
    app.get { req -> EventLoopFuture<View> in
        return try sensorsController.index(req)
    }
    
    try app.register(collection: sensorsController)
    
//    let sensorsController = SensorsController()
//    router.get("sensors", use: sensorsController.json)
//    router.post("sensors", use: sensorsController.create)
//
//    router.get { req -> Future<View> in
//        return try sensorsController.index(req)
//    }
}
