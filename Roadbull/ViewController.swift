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
    
    fileprivate var polyline: GMSPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        cameraZoomToCurrentLocation()
        initialMarkers()
    }
}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let infoWindow = InfoWindowView(frame: CGRect(x: 0, y: 0, width: 300, height: 180))
        if let place = marker.userData as? Place {
            infoWindow.place = place
        }
        return infoWindow
    }
}

extension ViewController {
    
    fileprivate func cameraZoomToCurrentLocation() {
        let camera = GMSCameraPosition.camera(withLatitude: 10.79, longitude: 106.68, zoom: 14)
        mapView.animate(to: camera)
    }
    
    fileprivate func initialMarkers() {
        
        let theCofferHouseGeo = CLLocationCoordinate2D(latitude: 10.7957471, longitude: 106.6876993)
        let theCoffeeHouse = Place(from: "Current location", address: "43 Hoa Hồng, Phường 25, Phú Nhuận, Hồ Chí Minh 700000, Việt Nam", postalCode: "149544", parcels: "120", remark: "Please go to Receiption and take the parcel from Lyon", geo: theCofferHouseGeo)
        
        let starbucksGeo = CLLocationCoordinate2D(latitude: 10.7947459, longitude: 106.6861651)
        let starbucks = Place(from: "Current location", address: "214-216 Phan Xích Long, Phường 7, Phú Nhuận, Hồ Chí Minh, Việt Nam", postalCode: "195577", parcels: "40", remark: "Please go to Receiption and take the parcel from Lyon", geo: starbucksGeo)
        
        let pergolaGeo = CLLocationCoordinate2D(latitude: 10.7935588, longitude: 106.6747881)
        let pergola = Place(from: "Current location", address: "28A Trần Cao Vân, phường 12, Hồ Chí Minh, Việt Nam", postalCode: "195577", parcels: "40", remark: "Please go to Receiption and take the parcel from Lyon", geo: pergolaGeo)
        
        let monkeyInBlackGeo = CLLocationCoordinate2D(latitude: 10.7891429, longitude: 106.6744448)
        let monkeyInBlack = Place(from: "Current location", address: "522 Lê Văn Sỹ, Phường 14, Quận 3, Hồ Chí Minh, Việt Nam", postalCode: "195070", parcels: "10", remark: "Please go to Receiption and take the parcel from Lyon", geo: monkeyInBlackGeo)
        
        let ozCoffeeGeo = CLLocationCoordinate2D(latitude: 10.787151, longitude: 106.6768695)
        let ozCoffee = Place(from: "Current location", address: "Hẻm 207 Lê Văn Sỹ, Phường 13, Quận 3, Hồ Chí Minh, Việt Nam", postalCode: "105070", parcels: "140", remark: "Please go to Receiption and take the parcel from Lyon", geo: ozCoffeeGeo)
        
        var places = [Place]()
        places.append(theCoffeeHouse)
        places.append(starbucks)
        places.append(pergola)
        places.append(monkeyInBlack)
        places.append(ozCoffee)
        
        for place in places {
            let marker = GMSMarker()
            marker.position = place.geo
            marker.userData = place
            marker.appearAnimation = .pop
            marker.map = mapView
        }
    }
    
    fileprivate func routing(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, mapView: GMSMapView) {
        
        let sourceLat = source.latitude
        let sourceLng = source.longitude
        let destinationLat = destination.latitude
        let destinationLng = destination.longitude
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLat),\(sourceLng)&destination=\(destinationLat),\(destinationLng)&key=AIzaSyC-rnrTYHPNYzWTVSBJRfmXX9_-kYi3L5w")!
        
        print(url)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        
                        if let routes = json["routes"] as? [Any], routes.count > 0 {
                            let overview_polyline = (routes[0] as? [String:Any])?["overview_polyline"] as? [String: Any]
                            let polyString = overview_polyline?["points"] as? String
                            
                            //Call this method to draw path on map
                            DispatchQueue.main.async(execute: {
                                self.showPath(polyStr: polyString!, mapView: mapView)
                            })
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    fileprivate func clearRoute() {
        polyline?.map = nil
    }
    
    fileprivate func showPath(polyStr: String, mapView: GMSMapView){
        clearRoute()
        
        let path = GMSPath(fromEncodedPath: polyStr)
        polyline = GMSPolyline(path: path)
        polyline?.strokeColor = UIColor.black
        polyline?.strokeWidth = 2.0
        polyline?.map = mapView
    }
}
