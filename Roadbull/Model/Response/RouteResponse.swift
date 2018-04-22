//
//  RouteResponse.swift
//  Roadbull
//
//  Created by TriNgo on 4/22/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import Foundation
import ObjectMapper

struct RouteResponse: Mappable {
    
    var routes: [Route]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        routes <- map["routes"]
    }
}
