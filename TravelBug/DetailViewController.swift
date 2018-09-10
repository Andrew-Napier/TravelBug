//
//  DetailViewController.swift
//  TravelBug
//
//  Created by Andrew Napier on 20/6/18.
//  Copyright © 2018 Andrew Napier. All rights reserved.
//

import MapKit
import UIKit

class MapDetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var dropPinGesture: UILongPressGestureRecognizer!
    var locationManager : CLLocationManager?
    
    
    func configureView() {
        // Attribution: https://stackoverflow.com/a/41227283
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500)
        mapView.setRegion(viewRegion, animated: false)
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 300, 300)
            mapView.setRegion(viewRegion, animated: false)
        }
        
        self.locationManager = locationManager
        
        DispatchQueue.main.async {
            self.locationManager?.startUpdatingLocation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    @IBAction func dropPin(_ sender: Any) {
        guard let gesture = sender as? UILongPressGestureRecognizer else {
            return
        }
        let longPressLocation = gesture.location(in: mapView)
        let pressedCoordinates = mapView.convert(longPressLocation, toCoordinateFrom: mapView)
        let annotation = MKPlacemark(coordinate: pressedCoordinates)
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        
        // add delegate to display the pin on the map.
    }
}

extension MapDetailViewController : CLLocationManagerDelegate {
}

