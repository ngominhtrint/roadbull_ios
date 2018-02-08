//
//  ViewController.swift
//  Roadbull
//
//  Created by TriNgo on 2/8/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraZoomToCurrentLocation()
        initialMarkers()
    }
}

extension ViewController {
    
    fileprivate func cameraZoomToCurrentLocation() {
        let camera = GMSCameraPosition.camera(withLatitude: 10.79, longitude: 106.68, zoom: 17)
        mapView.animate(to: camera)
    }
    
    fileprivate func initialMarkers() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 10.7957471, longitude: 106.6876993)
        marker.title = "The coffee house"
        marker.snippet = "43 Hoa Hồng, Phường 25, Phú Nhuận, Hồ Chí Minh 700000, Việt Nam"
        marker.appearAnimation = .pop
        marker.map = mapView
    }
}
