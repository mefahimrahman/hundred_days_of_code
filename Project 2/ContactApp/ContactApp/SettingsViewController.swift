//
//  SettingsViewController.swift
//  ContactApp
//
//  Created by Fahim Rahman on 3/4/22.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var sortPickerView: UIPickerView!
    @IBOutlet var ascendingSwitch: UISwitch!
    
    let sortOrderItems = ["Contact Name", "City", "Birthday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortPickerView.delegate = self
        sortPickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard
        
        let isAscendingSorted = userDefaults.bool(forKey: Strings.sortDirection)
        
        ascendingSwitch.setOn(isAscendingSorted, animated: true)
        
        let selectedSortField = userDefaults.string(forKey: Strings.sortBy)
        var position = 0
        for item in sortOrderItems {
            if item == selectedSortField {
                sortPickerView.selectRow(position, inComponent: 0, animated: false)
            }
            position += 1
        }
    }

    
    @IBAction func sortDirectionChanged(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(ascendingSwitch.isOn, forKey: Strings.sortDirection)
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
