//
//  DateViewController.swift
//  ContactApp
//
//  Created by Fahim Rahman on 11/4/22.
//

import UIKit

protocol DateContollerDelegate: AnyObject {
    func dateChanged(date: Date)
}

class DateViewController: UIViewController {
    
    @IBOutlet var dtpDate: UIDatePicker!
    
    weak var delegate: DateContollerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveDate))
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = "Pick Birthdate"
    }
    
    @objc func saveDate() {
        self.delegate?.dateChanged(date: dtpDate.date)
        self.navigationController?.popViewController(animated: true)
    }
}
