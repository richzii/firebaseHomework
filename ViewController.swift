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
    
    @IBOutlet weak var longitudeTxtField: UITextField!
    @IBOutlet weak var latitudeTxtField: UITextField!
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
    
    @IBAction func switchLongitude(_ sender: UISwitch) {
        if (sender.isOn == true) {
            longitudeTxtField.text = "-" + longitudeTxtField.text!
        } else {
            longitudeTxtField.text?.remove(at: longitudeTxtField.text!.startIndex)
        }
    }
    
    @IBAction func switchLatitude(_ sender: UISwitch) {
        if (sender.isOn == true) {
            latitudeTxtField.text = "-" + latitudeTxtField.text!
        } else {
            latitudeTxtField.text?.remove(at: latitudeTxtField.text!.startIndex)
        }
    }
    
    @IBAction func addToDataBase(_ sender: UIButton) {
        if (latitudeTxtField.text!.isEmpty || longitudeTxtField.text!.isEmpty) {
            let alert = UIAlertController(title: "Empty text fields!", message: "Make sure that you have filled both text fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil);
        } else if (Double (latitudeTxtField.text!)! > 90.0 || Double (latitudeTxtField.text!)! < -90.0) {
            let alert = UIAlertController(title: "Wrong latitude value!", message: "Latitude must be between -90 and 90", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil);
        } else if (Double (longitudeTxtField.text!)! > 180.0 || Double (longitudeTxtField.text!)! < -180.0) {
            let alert = UIAlertController(title: "Wrong longitude value!", message: "Longitude must be between -90 and 90", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil);
        } else {
            self.coordinates.append(latitudeTxtField.text! + " " + longitudeTxtField.text!)
            ref.setValue(self.coordinates)
        }
    }
}

