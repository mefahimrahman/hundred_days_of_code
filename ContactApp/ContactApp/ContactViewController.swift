//
//  ViewController.swift
//  ContactApp
//
//  Created by Fahim Rahman on 3/4/22.
//

import UIKit
import CoreData

class ContactViewController: UIViewController, DateContollerDelegate {

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contactTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var zipCodeTextField: UITextField!
    @IBOutlet var cellPhoneTextField: UITextField!
    @IBOutlet var homePhoneTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var lblBirthdate: UILabel!
    
    var currentContact: Contact?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeEditMode(self)
        
        let textFields: [UITextField] = [
            contactTextField,
            addressTextField,
            cityTextField,
            stateTextField,
            zipCodeTextField,
            cellPhoneTextField,
            homePhoneTextField,
            emailTextField
        ]
        
        for textField in textFields {
            textField.addTarget(self, action: #selector(ContactViewController.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingDidEnd)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.unregisterKeyboardNotifications()
    }
    
    
    @IBAction func changeEditMode(_ sender: Any) {
        let textFields: [UITextField] = [
            contactTextField,
            addressTextField,
            cityTextField,
            stateTextField,
            zipCodeTextField,
            cellPhoneTextField,
            homePhoneTextField,
            emailTextField
        ]
        
        if (segmentControl.selectedSegmentIndex == 0) {
            for eachTextField in textFields {
                eachTextField.isEnabled = false
                eachTextField.borderStyle = UITextField.BorderStyle.none
            }
            changeButton.isHidden = true
            navigationItem.rightBarButtonItem = nil
        }
        
        else if (segmentControl.selectedSegmentIndex == 1) {
            for eachTextField in textFields {
                eachTextField.isEnabled = true
                eachTextField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            changeButton.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveContactByCoreData))
        }
    }
    
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ContactViewController.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ContactViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = keyboardSize.height
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = 0
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc private func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (currentContact == nil) {
            let context = appDelegate.persistentContainer.viewContext
            currentContact = Contact(context: context)
        }
        
        currentContact?.contactname = contactTextField.text
        currentContact?.streetAddress = addressTextField.text
        currentContact?.city = cityTextField.text
        currentContact?.state = stateTextField.text
        currentContact?.zipCode = zipCodeTextField.text
        currentContact?.cellNumber = cellPhoneTextField.text
        currentContact?.phoneNumber = homePhoneTextField.text
        currentContact?.email = emailTextField.text
        return true
    }

    @objc func saveContactByCoreData() {
        appDelegate.saveContext()
        segmentControl.selectedSegmentIndex = 0
        changeEditMode(self)
    }
    
    func dateChanged(date: Date) {
        if (currentContact == nil) {
            let context = appDelegate.persistentContainer.viewContext
            currentContact = Contact(context: context)
        }
        currentContact?.birthday = date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        lblBirthdate.text = formatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueContactDate") {
            let dateController = segue.destination as! DateViewController
            dateController.delegate = self
        }
    }

}

