//
//  MapViewController.swift
//  World Trotter
//
//  Created by christian espinoza on 6/30/16.
//  Copyright © 2016 Christian Espinoza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    // let locationManager = CLLocationManager()
    
    override func loadView() {
      // create a mapview
        mapView = MKMapView()
        
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        
      // set it as the "view" of this controller 
        view = mapView
        
    // Here we are setting up the segmented control.
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
   // Add a target-action pair to the segemented controller and associate it with the .ValueChanged event
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)),
                                   forControlEvents: .ValueChanged)
  

        
    
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
    let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        
    let margins = view.layoutMarginsGuide
        
    let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
    let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true

        
        
        
        // Button Code
        
        let showLocButton = UIButton(type: .System)
        showLocButton.setTitle("My Location", forState: .Normal)
        showLocButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(showLocButton)
        
        showLocButton.addTarget(self, action: #selector(MapViewController.showLocButton(_:)), forControlEvents: .TouchUpInside)

     
        
let topButtonConstraint = showLocButton.topAnchor.constraintEqualToAnchor(segmentedControl.bottomAnchor, constant: 8)
        
let leadingButtonConstraint = showLocButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)

let trailingButtonConstraint = showLocButton.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
    topButtonConstraint.active = true
    leadingButtonConstraint.active = true
    trailingButtonConstraint.active = true
        
        
    }
    
    


    // Stuff that happens after the app starts running..
    override func viewDidLoad() {
     super.viewDidLoad()
        print("MapViewController loaded its view.")
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true // RESPONSIBLE FOR BLUE DOT
        

        

    }
    
    // Implement the action method that the above event will trigger!
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
        
    }
    
    // Implement the action that the location button will trigger when pressed!
    

    func showLocButton(sender: UIButton!) {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }

    
    
    // The following code is for the location delegate methods!
    
   // func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    //    let location = locations.last // updates to our last location
        
     //   let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude) // retrieves the "center" of that location from the location variable
        
      //  let region = MKCoordinateRegion(center: center,span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)) // responsible for the blue dot that we see, the 1 dictates how far zoomed in we will be
        
      //  self.mapView.setRegion(region, animated: true) // Sets the map view to the above region, animation zooms into the users current location.
        
      //  self.locationManager.stopUpdatingLocation() // Once we have everything we want we can stop zooming into the users current location.
        
   // }
    
   // func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
   //    print("Errors: " + error.localizedDescription)
   // }
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
    }
    
    
    
    
    
    
}
