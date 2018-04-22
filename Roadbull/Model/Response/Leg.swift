//
//  Leg.swift
//  Roadbull
//
//  Created by TriNgo on 4/22/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import Foundation
import ObjectMapper

struct Leg: Mappable {
    
    var distanceText: String?
    var distanceValue: Int?
    var durationText: String?
    var durationValue: Int?
    var endAddress: String?
    var endLocationLat: Double?
    var endLocationLng: Double?
    var startAddress: String?
    var startLocationLat: Double?
    var startLocationLng: Double?
    var steps: [Step]? 
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        distanceText <- map["distance.text"]
        distanceValue <- map["distance.value"]
        durationText <- map["duration.text"]
        durationValue <- map["duration.value"]
        endAddress <- map["end_address"]
        endLocationLat <- map["end_location.lat"]
        endLocationLng <- map["end_location.lng"]
        startAddress <- map["start_address"]
        startLocationLat <- map["start_location.lat"]
        startLocationLng <- map["start_location.lng"]
        steps <- map["steps"]
    }
}
