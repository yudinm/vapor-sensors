import Fluent

struct CreateSensors: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("sensors")
            .id()
            .field("co2", .double, .required)
            .field("temp", .double, .required)
            .field("humidity", .double, .required)
            .field("pressure", .double, .required)
            .field("createdAt", .datetime, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("sensors").delete()
    }
}
