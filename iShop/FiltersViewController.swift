//
//  FiltersViewController.swift
//  iShop
//
//  Created by lpiem on 11/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import UIKit

class FiltersViewController: UITableViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let minValue: Float = 0.0
        let maxValue: Float = 2500
        let currentValue: Float = 1250
        
        slider.maximumValue = maxValue
        slider.minimumValue = minValue
        slider.value = currentValue
    }
    
    // MARK: - Actions
    
    @IBAction func onValueChange(_ sender: UISlider) {
        
        lblValue.text = String(slider.value) + "€"
    }
}
