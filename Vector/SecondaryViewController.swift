//
//  SecondaryViewController.swift
//  Vector
//
//  Created by William Connell on 10/18/19.
//  Copyright © 2019 Will Connell. All rights reserved.
//

import UIKit

class SecondaryViewController: UIViewController {

    @IBOutlet weak var xLabel: UILabel?
    @IBOutlet weak var yLabel: UILabel?
    @IBOutlet weak var vLabel: UILabel?
    @IBOutlet weak var thetaLabel: UILabel?
    @IBOutlet weak var warningNote: UILabel!
    
    var vector : Vector?
    var displayNote = false
    
    
    // Dismiss SecondaryViewController when back is pressed
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // If values entered incorrectly, display only the Instructions
        if displayNote == true {
            warningNote.text = "Instructions: Enter any two values describing the vector and press 'Calculate' to calculate the remaining two unknowns. Make sure to leave the text boxes blank for the unkown values. (If you are seeing this message, values were entered incorrectly)"
            xLabel?.text = ""
            yLabel?.text = ""
            vLabel?.text = ""
            thetaLabel?.text = ""
        }
        // Otherwise display all four calcualted parameters of the vector
        else {
            xLabel?.text = "X = " + (vector?.x ?? "unknown")
            yLabel?.text = "Y = " + (vector?.y ?? "unknown")
            vLabel?.text = "V = " + (vector?.v ?? "unknown")
            thetaLabel?.text = "θ = " + (vector?.theta ?? "unknown")
            warningNote.text = ""
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
