//
//  ConversionViewController.swift
//  World Trotter
//
//  Created by christian espinoza on 6/28/16.
//  Copyright © 2016 Christian Espinoza. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    override func viewWillAppear(animated: Bool) {
        let hour = NSCalendar.currentCalendar().component(NSCalendarUnit.Hour, fromDate: NSDate())
        if (hour > 18 || hour < 6) {
            view.backgroundColor = UIColor.lightGrayColor()
        } else {
            view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    override func viewDidLoad() {
        
        //Always call the super implementation of view did load
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
    }
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        
        // if let text = textField.text, value = Double(text) {
        //    fahrenheitValue = value
        // }
        // else {
        //    fahrenheitValue = nil
        // }
        
        
        // UPDATE TO TEXT TO ALLOW CELSIUS TO RECOGNIZE COMMAS AS SEPARATORS
        
        if let text = textField.text, number = numberFormatter.numberFromString(text) {
            fahrenheitValue = number.doubleValue
        }
        else {
            fahrenheitValue = nil
        }
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            // celsiusLabel.text = "\(value)"
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    // LOCATION UNIVERSILIZATION WORK ZONE
    
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
    
       // let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
       // let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        
        // CHANGES TO NSLOCALE SETTINGS
        
        let currentLocale = NSLocale.currentLocale() // setting a variable "currentLocale" to the current regions settings
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String // calling the objectForKey method on currentLocale and passing in NSLocaleDecimalSeparator as a string
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        // Bronze Challenge
        let letters = NSCharacterSet.letterCharacterSet()
        if string.lowercaseString.rangeOfCharacterFromSet(letters) != nil {
            return false
        }
        else {
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
        
        }
   
    }
    
   
    
}
