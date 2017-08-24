//
//  ViewController.swift
//  Tip-O-Matic
//
//  Created by Cesar Cavazos on 8/22/17.
//  Copyright © 2017 Cesar Cavazos. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPercentages:[Double]!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        
        // Change the alpha of the control
        self.tipControl.alpha = 0
        
        // Read the values from default
        let defaults = UserDefaults.standard
        let firstTabValue = defaults.double(forKey: "firstStepper") 
        let secondTabValue = defaults.double(forKey: "secondStepper")
        let thirdTabValue = defaults.double(forKey: "thirdStepper")
        
        // Lets add some default values if non are created (first time the app launches
        if firstTabValue == 0 && secondTabValue == 0 && thirdTabValue == 0 {
            tipPercentages = [15, 20, 25]
            // Save those values
            let defaults = UserDefaults.standard
            defaults.set(tipPercentages[0], forKey: "firstStepper")
            defaults.set(tipPercentages[1], forKey: "secondStepper")
            defaults.set(tipPercentages[2], forKey: "thirdStepper")
            defaults.synchronize()
        } else {
            tipPercentages = [firstTabValue, secondTabValue, thirdTabValue]
        }
        
        // Set the segmented control to the current values
        tipControl.setTitle(String(format: "%.0f%%", tipPercentages[0]), forSegmentAt: 0)
        tipControl.setTitle(String(format: "%.0f%%", tipPercentages[1]), forSegmentAt: 1)
        tipControl.setTitle(String(format: "%.0f%%", tipPercentages[2]), forSegmentAt: 2)
        
        // Lets reset the fields so we don't show data if the user changes the settings
        billField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // Animate the title control with the new values
        UIView.animate(withDuration: 0.4) { 
            self.tipControl.alpha = 1
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let defaults = UserDefaults.standard
        let bill = defaults.string(forKey: "billAmount")
        if bill != nil {
            // If a previous bill exists, lets prepopulate it and calculate the tip
            billField.text = bill!
            calculateTip(billField)
        }
        // Make sure we are focusing the textfield when this gets created
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        // Commenting this out since we don't want to keyboard to be dismissed
        //view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex] / 100
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        // Save the input 
        let defaults = UserDefaults.standard
        defaults.set(billField.text!, forKey: "billAmount")
        defaults.synchronize()
    }
}

