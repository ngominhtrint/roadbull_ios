//
//  Step.swift
//  Roadbull
//
//  Created by TriNgo on 4/22/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import Foundation
import ObjectMapper

struct Step: Mappable {
    
    var distanceText: String?
    var distanceValue: Int?
    var durationText: String?
    var durationValue: Int?
    var endLocationLat: Double?
    var endLocationLng: Double?
    var htmlInstructions: String?
    var polylinePoint: String?
    var startLocationLat: Double?
    var startLocationLng: Double?
    var travelMode: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        distanceText <- map["distance.text"]
        distanceValue <- map["distance.value"]
        durationText <- map["duration.text"]
        durationValue <- map["duration.value"]
        endLocationLat <- map["end_location.lat"]
        endLocationLng <- map["end_location.lng"]
        htmlInstructions <- map["html_instructions"]
        polylinePoint <- map["polyline.points"]
        startLocationLat <- map["start_location.lat"]
        startLocationLng <- map["start_location.lng"]
        travelMode <- map["travel_mode"]
    }
}
