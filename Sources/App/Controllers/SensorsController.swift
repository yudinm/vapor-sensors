//
//  SensorsController.swift
//  
//
//  Created by Michael Yudin on 17.07.2020.
//

import Vapor
import Leaf

final class SensorsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let sensors = routes.grouped("sensors")
        sensors.get(use: index)
        sensors.post(use: create)
//        sensors.group(":sensorsID") { sensors in
//            sensors.delete(use: delete)
//        }
    }
    
    static let defaultLimit = 1024
    
    var recordsLimit = defaultLimit
    
    struct SensorsContext: Encodable {
        let title: String
        let data: [Sensors]
        let lastCO2: Double
        let lastPre: Double
        let lastTem: Double
        let lastHum: Double
    }
    
    func index(_ req: Request) throws -> EventLoopFuture<View> {
        do {
            self.recordsLimit = try req.query.get(at: "l") as Int
        } catch {
            self.recordsLimit = SensorsController.defaultLimit
        }
        
        return
            Sensors.query(on: req.db)
                .sort(\Sensors.$id, .descending)
                .range(lower: 0, upper: recordsLimit)
                .all()
                .flatMap({ sensorsData -> EventLoopFuture<View> in
                    let lastSensor = (sensorsData as [Sensors]).last
                    return req.view.render("sensors",
                                           SensorsContext(title: "Weather",
                                                          data: sensorsData,
                                                          lastCO2: lastSensor?.co2 ?? 0,
                                                          lastPre: lastSensor?.pressure ?? 0,
                                                          lastTem: lastSensor?.temp ?? 0,
                                                          lastHum: lastSensor?.humidity ?? 0))
                })
    }
    
    func json(_ req: Request) throws -> EventLoopFuture<[Sensors]> {
        return Sensors.query(on: req.db)
            .sort(\Sensors.$id, .descending)
            .range(lower: 0, upper: recordsLimit)
            .all()
    }
    
    func create(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let sensors = try req.content.decode(Sensors.self)
        sensors.createdAt = Date()
        return sensors.save(on: req.db).map { sensors in
            return .accepted
        }
    }
    
}
