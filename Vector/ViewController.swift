//
//  ViewController.swift
//  Vector
//
//  Created by William Connell on 9/26/19.
//  Copyright © 2019 Will Connell. All rights reserved.
//



import UIKit


class ViewController: UIViewController {
    
    // Create objects for text fields
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var vTextField: UITextField!
    @IBOutlet weak var thetaTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup for showing and hiding keyboard when textfield is selected
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Exit text field when empty space outside textfield is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        xTextField.resignFirstResponder()
        yTextField.resignFirstResponder()
        thetaTextField.resignFirstResponder()
        vTextField.resignFirstResponder()
    }
    
    // Make text fields move up in sync with keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    // Make text fields move down in sync with keyboard
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // initialize variables outside of calculatePressed function
    var vectorone = Vector(x: "", y: "", v: "", theta: "")
    var xvalue: Double = 0
    var yvalue: Double = 0
    var vvalue: Double = 0
    var tvalue: Double = 0
    var incorrectEntry = false
    var n: Double = 100 // round answers to the nearest 100th
    
    

    @IBAction func calculatePressed(_ sender: UIButton) {
        // set vector properties equal to text field entries
        self.vectorone = Vector(x: xTextField.text!, y: yTextField.text!, v: vTextField.text!, theta: thetaTextField.text!)
        
        incorrectEntry = false
        
        // The actual calculations:
        // x,y known
        if xTextField.text != "" && yTextField.text != "" && vTextField.text == "" && thetaTextField.text == "" {
            xvalue = Double(xTextField.text!)!
            yvalue = Double(yTextField.text!)!
            vvalue = (xvalue * xvalue + yvalue * yvalue).squareRoot()
            tvalue = atan(yvalue / xvalue)
        }
        // x,t known
        else if xTextField.text != "" && thetaTextField.text != "" && yTextField.text == "" && vTextField.text == "" {
            xvalue = Double(xTextField.text!)!
            tvalue = Double(thetaTextField.text!)!
            yvalue = xvalue * tan(tvalue)
            vvalue = xvalue / cos(tvalue)
        }
        // x,v known
        else if xTextField.text != "" && vTextField.text != "" && yTextField.text == "" && thetaTextField.text == "" {
            xvalue = Double(xTextField.text!)!
            vvalue = Double(vTextField.text!)!
            tvalue = acos(xvalue / vvalue)
            yvalue = (vvalue * vvalue - xvalue * xvalue).squareRoot()
        }
        // y,v known
        else if yTextField.text != "" && vTextField.text != "" && xTextField.text == "" && thetaTextField.text == "" {
            yvalue = Double(yTextField.text!)!
            vvalue = Double(vTextField.text!)!
            xvalue = (vvalue * vvalue - yvalue * yvalue).squareRoot()
            tvalue = asin(yvalue / vvalue)
        }
        // y,t known
        else if yTextField.text != "" && thetaTextField.text != "" && xTextField.text == "" && vTextField.text == "" {
            yvalue = Double(yTextField.text!)!
            tvalue = Double(thetaTextField.text!)!
            xvalue = yvalue / tan(tvalue)
            vvalue = yvalue / sin(tvalue)
        }
        // v,t known
        else if vTextField.text != "" && thetaTextField.text != "" && yTextField.text == "" && xTextField.text == "" {
            tvalue = Double(thetaTextField.text!)!
            vvalue = Double(vTextField.text!)!
            xvalue = vvalue * cos(tvalue)
            yvalue = vvalue * sin(tvalue)
        }
        else {
            self.incorrectEntry = true
        }
        
        // update vector with all four correct values, rounded to the nearest 100th
        self.vectorone = Vector(x: String(round(n*xvalue)/n), y: String(round(yvalue*n)/n), v: String(round(n*vvalue)/n), theta: String(round(n*tvalue)/n))

        
        performSegue(withIdentifier: "segueOne", sender: self)
        
        // Exit text fields when calculate button is pressed
        xTextField.resignFirstResponder()
        yTextField.resignFirstResponder()
        thetaTextField.resignFirstResponder()
        vTextField.resignFirstResponder()
    }
    
    // use segue to pass data to SecondaryViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondaryViewController = segue.destination as? SecondaryViewController
        secondaryViewController?.vector = self.vectorone
        secondaryViewController?.displayNote = self.incorrectEntry
    }
    

}


// Features to add:
// switch from radians to degrees
// specify number of decimal accuracy
// ^would probably have to nest these features in a separate settings page to prevent the main screen
// from becoming overcrowded

// Fix: bug on iPhone XS where the keyboard partially covers the 'calculate' button only after hitting the back button to the main view; only appears to be a bug for the iPhone X's

// (Fixed 10/23/19): problem where once instructions appear, they don't go away, even once back is pressed and a correct entry occurs

