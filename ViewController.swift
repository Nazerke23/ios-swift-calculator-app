//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Назерке Кулан on 19.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var typing: Bool = false

    @IBOutlet weak var myDisplay: UILabel!
    
    @IBAction func digitPressed(_ sender: UIButton) {
        let current_digit = sender.currentTitle!
        
        if typing{
            let current_display = myDisplay.text!
            myDisplay.text = current_display + current_digit
        }else{
            myDisplay.text = current_digit
            typing = true
        }
    }
    
    
    
    @IBAction func deleteButton() {
        myDisplay.text = "0"
        typing = false
    }
    
    //Computed property
    
    var displayValue: Double {
        get{
            return Double(myDisplay.text!)!
        }
        set{
            myDisplay.text = String(newValue)
        }
    }
    
    
    private var calculatorModel = CalculatorModel()
     
    
    @IBAction func operationPressed(_ sender: UIButton) {
        calculatorModel.setOperand(displayValue)
        calculatorModel.performOperation(sender.currentTitle!)
        displayValue = calculatorModel.result!
        
        
        typing = false
    }
    
    
    
    
    
    
}

