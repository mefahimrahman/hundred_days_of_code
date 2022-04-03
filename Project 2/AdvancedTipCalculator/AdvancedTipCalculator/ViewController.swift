//
//  ViewController.swift
//  AdvancedTipCalculator
//
//  Created by Fahim Rahman on 31/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Button1: UIButton!
    @IBOutlet var Button2: UIButton!
    @IBOutlet var Button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Button1.title(for: UIControl.State.highlighted)
    }
    
    @IBAction func Button1Pressed(_ sender: Any) {
        print("Button 1 Pressed")
        
    }

    @IBAction func Button2Pressed(_ sender: Any, forEvent event: UIEvent) {
        print("Button 2 Pressed sender -> \(sender) and event \(event)")
    }
    
    @IBAction func Button3Pressed(_ sender: Any, forEvent event: UIEvent) {
        print("Button 3 Pressed sender -> \(sender) and event \(event)")
    }
}

