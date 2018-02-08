//
//  Place.swift
//  Roadbull
//
//  Created by TriNgo on 2/8/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import Foundation
import GoogleMaps

struct Place {
    let from: String
    let address: String
    let postalCode: String
    let parcels: String
    let remark: String
    let geo: CLLocationCoordinate2D
}
