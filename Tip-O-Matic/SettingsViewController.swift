//
//  SettingsViewController.swift
//  Tip-O-Matic
//
//  Created by Cesar Cavazos on 8/22/17.
//  Copyright © 2017 Cesar Cavazos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var firstStepper: UIStepper!
    @IBOutlet weak var secondStepper: UIStepper!
    @IBOutlet weak var thirdStepper: UIStepper!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Load defaults if any")
        
        // Read the values from default
        let defaults = UserDefaults.standard
        let firstTabValue = defaults.double(forKey: "firstStepper")
        let secondTabValue = defaults.double(forKey: "secondStepper")
        let thirdTabValue = defaults.double(forKey: "thirdStepper")
        
        // Set the segmented control to the current values
        tipControl.setTitle(String(format: "%.0f%%", firstTabValue), forSegmentAt: 0)
        tipControl.setTitle(String(format: "%.0f%%", secondTabValue), forSegmentAt: 1)
        tipControl.setTitle(String(format: "%.0f%%", thirdTabValue), forSegmentAt: 2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Lets save the settings to the local filesystem
        print("Will save defaults")
        let defaults = UserDefaults.standard
        defaults.set(firstStepper.value, forKey: "firstStepper")
        defaults.set(secondStepper.value, forKey: "secondStepper")
        defaults.set(thirdStepper.value, forKey: "thirdStepper")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstTab(_ sender: Any) {
        let value = String(format: "%.0f%%", firstStepper.value);
        tipControl.setTitle(value, forSegmentAt: 0)
    }
    
    @IBAction func secondTab(_ sender: Any) {
        let value = String(format: "%.0f%%", secondStepper.value);
        tipControl.setTitle(value, forSegmentAt: 1)
    }

    @IBAction func thirdTab(_ sender: Any) {
        let value = String(format: "%.0f%%", thirdStepper.value);
        tipControl.setTitle(value, forSegmentAt: 2)
    }
    
}
