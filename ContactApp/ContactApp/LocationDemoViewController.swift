//
//  LocationDemoViewController.swift
//  ContactApp
//
//  Created by Fahim Rahman on 24/4/22.
//

import UIKit
import CoreLocation

class LocationDemoViewController: UIViewController {

    @IBOutlet var txtStreet: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtState: UITextField!
    
    @IBOutlet var lblLatitude: UILabel!
    @IBOutlet var lblLongitude: UILabel!
    @IBOutlet var lblLocationAccuracy: UILabel!
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet var lblHeadingAccuracy: UILabel!
    
    @IBOutlet var lblAltitude: UILabel!
    @IBOutlet var lblAltitudeAccuracy: UILabel!
    
    lazy var geoCOder = CLGeocoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func addressToCoordinates(_ sender: Any) {
        let address = "\(txtStreet.text!), \(txtCity.text!), \(txtState.text!)"
        
        geoCOder.geocodeAddressString(address) { (placemarks, error) in
            self.processAddressResponse(withPlacemarks: placemarks, error: error)
        }
        
    }
    
    @IBAction func deviceCoordinates(_ sender: Any) {
    }
        
    private func processAddressResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("GeoCode Error: \(error)")
        } else {
            var bestMatch: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                bestMatch = placemarks.first?.location
            }
            if let coordinate = bestMatch?.coordinate {
                lblLatitude.text = String(format: "%g\u{00B0}", coordinate.latitude)
                lblLongitude.text = String(format: "%g\u{00B0}", coordinate.longitude)
            } else {
                print("Didn't find any matching locations")
            }
        }
    }
    
}
