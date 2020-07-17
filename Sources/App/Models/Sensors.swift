//
//  Sensors.swift
//  
//
//  Created by Michael Yudin on 17.07.2020.
//

import Fluent
import Vapor

//struct SensorsRequest: Content {
//    var co2: Double
//    var temp: Double
//    var humidity: Double
//    var pressure: Double
//}

final class Sensors: Model, Content {
    
    init() {}
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "co2")
    var co2: Double
    @Field(key: "temp")
    var temp: Double
    @Field(key: "humidity")
    var humidity: Double
    @Field(key: "pressure")
    var pressure: Double
    @Field(key: "createdAt")
    var createdAt: Date?
    
    static let schema = "sensors"
    
    init(id: UUID? = nil, co2: Double, temp: Double, humidity: Double, pressure: Double) {
        self.id = id
        self.co2 = co2
        self.temp = temp
        self.humidity = humidity
        self.pressure = pressure
    }
}

