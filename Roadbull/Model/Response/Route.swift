//
//  Route.swift
//  Roadbull
//
//  Created by TriNgo on 4/22/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import Foundation
import ObjectMapper

struct Route: Mappable {
    
    var boundNorthEastLat: Double?
    var boundNorthEastLng: Double?
    var boundSoundWestLat: Double?
    var boundSoundWestLng: Double?
    var copyrights: String?
    var legs: [Leg]?
    var overviewPolylinePoints: String?
    var summary: String?
    var waypointOrder: [Int]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        boundNorthEastLat <- map["bounds.northeast.lat"]
        boundNorthEastLng <- map["bounds.northeast.lng"]
        boundSoundWestLat <- map["bounds.southwest.lat"]
        boundSoundWestLng <- map["bounds.southwest.lng"]
        copyrights <- map["copyrights"]
        legs <- map["legs"]
        overviewPolylinePoints <- map["overview_polyline.points"]
        summary <- map["summary"]
        waypointOrder <- map["waypoint_order"]
    }
}
