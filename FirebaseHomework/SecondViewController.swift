//
//  SecondViewController.swift
//  FirebaseHomework
//
//  Created by Rihards Zīverts on 12/05/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController {

    @IBOutlet weak var longitudeTxtField: UITextField!
    @IBOutlet weak var latitudeTxtField: UITextField!
    var ref: DatabaseReference!
    var coordinates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
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
            let alert = UIAlertController(title: "Wrong longitude value!", message: "Longitude must be between -180 and 180", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil);
        } else {
            self.coordinates.append(latitudeTxtField.text! + " " + longitudeTxtField.text!)
            ref.setValue(self.coordinates)
        }
    }
}
