//
//  SettingsViewController.swift
//  ContactApp
//
//  Created by Fahim Rahman on 3/4/22.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pckSortField: UIPickerView!
    @IBOutlet var swAscending: UISwitch!
    
    let sortOrderItems = ["Contact Name", "City", "Birthday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pckSortField.delegate = self
        pckSortField.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard
        
        let isAscendingSorted = userDefaults.bool(forKey: Strings.sortDirection)
        
        swAscending.setOn(isAscendingSorted, animated: true)
        
        let selectedSortField = userDefaults.string(forKey: Strings.sortBy)
        var position = 0
        for item in sortOrderItems {
            if item == selectedSortField {
                pckSortField.selectRow(position, inComponent: 0, animated: false)
            }
            position += 1
        }
    }

    
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(swAscending.isOn, forKey: Strings.sortDirection)
        userDefaults.synchronize()
    }
}

extension SettingsViewController {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sortOrderItems.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        sortOrderItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Chossen Item: \(sortOrderItems[row])")
        let selectedSortField = sortOrderItems[row]
        let userDefaults = UserDefaults.standard
        userDefaults.set(selectedSortField, forKey: Strings.sortBy)
        userDefaults.synchronize()
    }
    
}
