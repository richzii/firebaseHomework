//
//  ViewController.swift
//  FirebaseHomework
//
//  Created by Rihards Zīverts on 02/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var coordinates = [String]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        ref.observe(.value) { snapshot in
            let coordinatePoint = MKPointAnnotation()
            let arrayOfCoordinates = snapshot.value as? [String] ?? []
            var currentLatitude = 0.00
            var currentLongitude = 0.00
            self.coordinates = arrayOfCoordinates
            
            if self.coordinates.isEmpty == false {
                self.coordinates.forEach{ coordinate in
                    currentLatitude = (coordinate.components(separatedBy: " ")[0] as NSString).doubleValue
                    currentLongitude = (coordinate.components(separatedBy: " ")[1] as NSString).doubleValue
                }
                
                coordinatePoint.coordinate = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
                
                self.mapView.addAnnotation(coordinatePoint)
            }
        }
    }
}

