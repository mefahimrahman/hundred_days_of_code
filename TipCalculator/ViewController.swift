//
//  ViewController.swift
//  TipCalculator
//
//  Created by Fahim Rahman on 28/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var inputField: UITextField!
    
    @IBOutlet var fifteenPercentButton: UIButton!
    @IBOutlet var eighteenPercentButton: UIButton!
    @IBOutlet var thirtyPercentButton: UIButton!
    
    @IBOutlet var resultTextView: UITextView!
    
    var value: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultTextView.text = ""
    }
    
    @IBAction func fifteenPercentTapped(_ sender: Any) {
        value = Double(inputField.getText()) ?? 0.0
        if (!inputField.getText().isEmpty) {
            resultTextView.text = "Tip $\((value*0.15).twoDecimal) Total $\((value + value*0.15).twoDecimal)"
        }
        
    }
    @IBAction func eighteenPercentTapped(_ sender: Any) {
        value = Double(inputField.getText()) ?? 0.0
        if (!inputField.getText().isEmpty) {
            resultTextView.text = "Tip $\((value*0.18).twoDecimal) Total $\((value + value*0.18).twoDecimal)"
        }
    }
    @IBAction func thirtyPercentTapped(_ sender: Any) {
        value = Double(inputField.getText()) ?? 0.0
        if (!inputField.getText().isEmpty) {
            resultTextView.text = "Tip $\((value*0.30).twoDecimal) Total $\((value + value*0.30).twoDecimal)"
        }
    }
}

extension UITextField {
    func getText() -> String {
        return self.text ?? ""
    }
}

extension Double {
    var twoDecimal: String {
        String(format: "$%0.2f", self)
    }
}

//extension ViewController : UITextInputDelegate {
//    func selectionWillChange(_ textInput: UITextInput?) {
//
//    }
//
//    func selectionDidChange(_ textInput: UITextInput?) {
//
//    }
//
//    func textWillChange(_ textInput: UITextInput?) {
//
//    }
//
//    func textDidChange(_ textInput: UITextInput?) {
//
//    }
//
//
//}

