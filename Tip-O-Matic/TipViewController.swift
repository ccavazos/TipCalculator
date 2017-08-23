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
        print("Load defaults if any")
        
        // Change the alpha of the control
        self.tipControl.alpha = 0
        
        // Read the values from default
        let defaults = UserDefaults.standard
        let firstTabValue = defaults.double(forKey: "firstStepper") 
        let secondTabValue = defaults.double(forKey: "secondStepper")
        let thirdTabValue = defaults.double(forKey: "thirdStepper")
        tipPercentages = [firstTabValue, secondTabValue, thirdTabValue]
        
        // Set the segmented control to the current values
        tipControl.setTitle(String(format: "%.0f%%", firstTabValue), forSegmentAt: 0)
        tipControl.setTitle(String(format: "%.0f%%", secondTabValue), forSegmentAt: 1)
        tipControl.setTitle(String(format: "%.0f%%", thirdTabValue), forSegmentAt: 2)
        
        // Lets reset the fields so we don't show data if the user changes the settings
        billField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // Animate the title control with the new values
        UIView.animate(withDuration: 0.4) { 
            self.tipControl.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

