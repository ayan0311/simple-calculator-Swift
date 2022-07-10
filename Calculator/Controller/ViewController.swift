//
//  ViewController.swift
//  Calculator
//
//  Created by Ayan Sarkar on 11/07/2022. Layout and design by Dr. Angela Yu
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var doneTypingNumber = true
    private var check = true
    private var calcMethod : String?
    private var displayValue : Double {
        get {
            guard let value = Double(displayLabel.text!) else {
                fatalError("Cannot convert value to string!")
            }
            return value
        }set {
            print(newValue)
            if floor(newValue) == newValue {
            displayLabel.text = String(format: "%.0f", newValue)
            } else{
                displayLabel.text = String(newValue)
            }
        }
    }
    
    private var calculator = Logic()
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        doneTypingNumber = true
        calcMethod = sender.currentTitle
        if calcMethod == "AC" || calcMethod == "+/-" || calcMethod == "%" || calcMethod == "=" {
            sendToCalculate()
        } else if check{
            sendToCalculate()
            check = false
        } else if check == false {
            calcMethod = nil
            sendToCalculate()
            calcMethod = sender.currentTitle
            sendToCalculate()
        }
    }
    
    func sendToCalculate(){
        calculator.setNumber(displayValue)
        let result = calculator.calculate(with: calcMethod)
        if result != nil {
            displayValue = result!
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        check = true
        if let num = sender.currentTitle {
            if doneTypingNumber {
                if num == "." {
                    displayLabel.text = "0"+num
                }else {
                    displayLabel.text = num
                }
                doneTypingNumber = false
            }else{
                if floor(displayValue) != displayValue{
                    return
                } else  {
            displayLabel.text?.append(contentsOf: num)
                }
            }
        }
    }

}

