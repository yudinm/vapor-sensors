import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {

    let sensorsController = SensorsController()
    app.get("sensors", use: sensorsController.json)
    app.post("sensors", use: sensorsController.create)
    app.get { req -> EventLoopFuture<View> in
        return try sensorsController.index(req)
    }
    
    try app.register(collection: sensorsController)

}
