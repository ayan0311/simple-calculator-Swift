//
//  ViewController.swift
//  Calculator
//
//  Created by Ayan Sarkar on 11/07/2022. Layout and design by Dr. Angela Yu
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var calcButtonTapped = UIButton()
    private var doneTypingNumber = true
    private var check = true
    private var decimalTapped = false
    private var calcMethod : String?
    private var displayValue : Double {
        get {
            guard let value = Double(displayLabel.text!) else {
                fatalError("Cannot convert value to string!")
            }
            return value
        }set {
            if newValue == 0 {
                displayLabel.text = String(format: "%.0f", newValue)
            }else {
            displayLabel.text = refactorStringWithCommas(newValue)
            }
        }
    }
    
    private var calculator = Logic()
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        doneTypingNumber = true
        decimalTapped = false
        calcMethod = sender.currentTitle
        
        //button tap modification begins
        calcButtonTapped.backgroundColor = .systemOrange
        if calcMethod == "AC" || calcMethod == "+/-" || calcMethod == "%" || calcMethod == "=" {
            sender.alpha = 0.75
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                sender.alpha = 1.0
            }
        } else {
            calcButtonTapped = sender
            sender.backgroundColor = .red
        }
        
        
        //button modification ends
        
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
        //button tap modification
        sender.alpha = 0.75
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            sender.alpha = 1.0
        }
        //button modification ends
        
        check = true
        if let num = sender.currentTitle {
            if doneTypingNumber {
                if num == "." {
                    decimalTapped = true
                    displayLabel.text = "0" + num
                }else {
                    displayLabel.text = num
                }
                doneTypingNumber = false
            }else{
                if decimalTapped && num == "."{
                    return
                } else  {
                    if num == "."{
                        decimalTapped = true
                    }
                    displayLabel.text?.append(contentsOf: num)
                }
            }
        }
    }
    
    func refactorStringWithCommas(_ n : Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: n as NSNumber)
        return formattedNumber!
    }
    
}

