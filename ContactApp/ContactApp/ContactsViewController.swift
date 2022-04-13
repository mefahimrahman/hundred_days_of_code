//
//  ViewController.swift
//  ContactApp
//
//  Created by Fahim Rahman on 3/4/22.
//

import UIKit
import CoreData

class ContactsViewController: UIViewController, DateContollerDelegate {

    @IBOutlet var sgmtEditMode: UISegmentedControl!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtAddress: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtState: UITextField!
    @IBOutlet var txtZip: UITextField!
    @IBOutlet var txtCell: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var btnChange: UIButton!
    @IBOutlet var lblBirthdate: UILabel!
    
    var currentContact: Contact?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentContact != nil {
            txtName.text = currentContact!.contactName
            txtAddress.text = currentContact!.streetAddress
            txtCity.text = currentContact!.city
            txtState.text = currentContact!.state
            txtZip.text = currentContact!.zipCode
            txtPhone.text = currentContact!.phoneNumber
            txtCell.text = currentContact!.cellNumber
            txtEmail.text = currentContact!.email
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            if (currentContact!.birthday != nil) {
                lblBirthdate.text = formatter.string(from: currentContact!.birthday!)
            }
        }
        
        changeEditMode(self)
        
        let textFields: [UITextField] = [
            txtName,
            txtAddress,
            txtCity,
            txtState,
            txtZip,
            txtCell,
            txtPhone,
            txtEmail
        ]
        
        for textField in textFields {
            textField.addTarget(self, action: #selector(ContactsViewController.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingDidEnd)
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
            txtName,
            txtAddress,
            txtCity,
            txtState,
            txtZip,
            txtCell,
            txtPhone,
            txtEmail
        ]
        
        if (sgmtEditMode.selectedSegmentIndex == 0) {
            for eachTextField in textFields {
                eachTextField.isEnabled = false
                eachTextField.borderStyle = UITextField.BorderStyle.none
            }
            btnChange.isHidden = true
            navigationItem.rightBarButtonItem = nil
        }
        
        else if (sgmtEditMode.selectedSegmentIndex == 1) {
            for eachTextField in textFields {
                eachTextField.isEnabled = true
                eachTextField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            btnChange.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveContactByCoreData))
        }
    }
    
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ContactsViewController.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ContactsViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        
        currentContact?.contactName = txtName.text
        currentContact?.streetAddress = txtAddress.text
        currentContact?.city = txtCity.text
        currentContact?.state = txtState.text
        currentContact?.zipCode = txtZip.text
        currentContact?.cellNumber = txtCell.text
        currentContact?.phoneNumber = txtPhone.text
        currentContact?.email = txtEmail.text
        return true
    }

    @objc func saveContactByCoreData() {
        appDelegate.saveContext()
        sgmtEditMode.selectedSegmentIndex = 0
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

