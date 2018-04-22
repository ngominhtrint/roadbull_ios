//
//  ViewController.swift
//  Roadbull
//
//  Created by TriNgo on 2/8/18.
//  Copyright © 2018 TriNgo. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import ObjectMapper

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    fileprivate var polyline: GMSPolyline?
    fileprivate var currentLocation: CLLocationCoordinate2D!
    fileprivate var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        routing(source: currentLocation, destination: marker.position, mapView: mapView)
        return false
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            currentLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 15.0)
            mapView.animate(to: camera)
        }
        
        self.locationManager.stopUpdatingLocation()
    }
}

extension ViewController {
    
    fileprivate func cameraZoomToCurrentLocation() {
        let camera = GMSCameraPosition.camera(withLatitude: 10.79, longitude: 106.68, zoom: 14.0)
        mapView.animate(to: camera)
    }
    
    fileprivate func initialMarkers() {
        
        // Saigon local places
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
        
        // Singapore local places
        let happyVinesGeo = CLLocationCoordinate2D(latitude: 1.3071002, longitude: 103.7615921)
        let happyVines = Place(from: "Happy Vines", address: "#04-385, Clementi West Street 2, Block 706, Singapore 120706", postalCode: "120706", parcels: "120", remark: "Please go to Receiption and take the parcel from Lyon", geo: happyVinesGeo)
        
        let internationalCommunitySchoolGeo = CLLocationCoordinate2D(latitude: 1.3070251, longitude: 103.7631907)
        let internationalCommunitySchool = Place(from: "International Community School", address: "27A Jubilee Rd, Singapore 128575", postalCode: "128575", parcels: "110", remark: "Please go to Receiption and take the parcel from Lyon", geo: internationalCommunitySchoolGeo)
        
        let clementiSwimmingGeo = CLLocationCoordinate2D(latitude: 1.3077759, longitude: 103.7635018)
        let clementiSwimming = Place(from: "Clementi Swimming", address: "520 Clementi Ave 3, Singapore 129908", postalCode: "129908", parcels: "10", remark: "Receiption and take the parcel from Lyon", geo: clementiSwimmingGeo)
        
        let phoonHuatGeo = CLLocationCoordinate2D(latitude: 1.312667, longitude: 103.7614741)
        let phoonHuat = Place(from: "Phoon Huat", address: "Blk 432 Clementi Avenue 3 #01-292/294, Singapore 120432", postalCode: "120432", parcels: "40", remark: "Receiption and take the parcel from Lyon", geo: phoonHuatGeo)
        
        let polyartAquariumGeo = CLLocationCoordinate2D(latitude: 1.3126149, longitude: 103.7473703)
        let polyartAquarium = Place(from: "PolyArt Aquarium", address: "Blk 328 Clementi Avenue 2 #01-194, Singapore 120328", postalCode: "120328", parcels: "70", remark: "Receiption and take the parcel from Lyon", geo: polyartAquariumGeo)
        
        var places = [Place]()
        places.append(happyVines)
        places.append(internationalCommunitySchool)
        places.append(clementiSwimming)
        places.append(phoonHuat)
        places.append(polyartAquarium)
        
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
        
        // waypoints: Happy Vines, International Community School
        // API_KEY no need to setup restrictions
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLat),\(sourceLng)&destination=\(destinationLat),\(destinationLng)&waypoints=optimize:true%7C1.312667%2C103.7614741%7C1.3070251%2C103.7631907%7C1.3077759%2C103.7635018&key=AIzaSyCYXXBZoKBv9nkZHxu1PrYGXuwE555o3jQ&sensor=true"
        let directionsURL = URL(string: urlString)!
        
        print(directionsURL)
        
        let routeMapper = Mapper<RouteResponse>()
        let task = session.dataTask(with: directionsURL, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        let routeResponse = routeMapper.map(JSON: json)
                        if let routes = routeResponse?.routes, let firstRoute = routes.first,
                            let overviewPolyline = firstRoute.overviewPolylinePoints, let waypointOrder = firstRoute.waypointOrder {
                            
                            DispatchQueue.main.async(execute: {
                                self.showPath(polyStr: overviewPolyline, mapView: mapView, color: .red)
                            })
                            print("Order: Phoon Huat #\(waypointOrder[0]), International School #\(waypointOrder[1]), Clementi Swimming #\(waypointOrder[2])")
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
    
    fileprivate func showPath(polyStr: String, mapView: GMSMapView, color: UIColor){
        clearRoute()
        
        let path = GMSPath(fromEncodedPath: polyStr)
        polyline = GMSPolyline(path: path)
        polyline?.strokeColor = color
        polyline?.strokeWidth = 2.0
        polyline?.map = mapView
    }
}
