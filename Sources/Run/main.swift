import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
if let port = Environment.get("PORT").flatMap(Int.init) {
    app.http.server.configuration.port = port
}
defer { app.shutdown() }
try configure(app)
try app.run()
