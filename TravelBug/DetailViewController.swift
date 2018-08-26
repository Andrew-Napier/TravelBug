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
    

    func configureView() {
        // Update the user interface for the detail item.
        //mapView.set
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


}

