//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipAmount = 0.10
    var totalBillAmout = 0.0
    var numberOfPeople = 0.0
    var amountForEachPerson = 0.0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        //how button got selected
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        //tip amount
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPctSign = String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPctSign)!
        tipAmount = buttonTitleAsANumber / 100
        
        billTextField.endEditing(true)
        
    }
    
    
    
    func calculateBill() -> String {
        totalBillAmout = Double(billTextField.text!)!
        amountForEachPerson = ( totalBillAmout + totalBillAmout * tipAmount ) / numberOfPeople
        let amountForEachPersonString = String(format: "%.2f", Float(amountForEachPerson))
        return amountForEachPersonString
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        sender.stepValue = 1
        let stepperValue = sender.value
        let stepperValueToInt = Int(stepperValue)
        splitNumberLabel.text = String(stepperValueToInt)
        numberOfPeople = Double(splitNumberLabel.text!)!
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        //calculateBill()
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultsVC = segue.destination as! ResultsViewController
            resultsVC.result = calculateBill()
            resultsVC.tip = Int(tipAmount * 100)
            resultsVC.split = Int(numberOfPeople)
        }
    }
}

