//
//  Logic.swift
//  Calculator
//
//  Created by Ayan Sarkar on 10/07/22.
//

import Foundation

struct Logic {
    
    private var number : Double?
    
    private var intermediateCalc : (num1: Double?, calcMethod: String?)?
    
    mutating func setNumber (_ num : Double){
        self.number = num
    }
    
    mutating func calculate(with symbol : String?) -> Double? {
        if let n = number, let operation = symbol{
        switch operation {
        case "AC":
            intermediateCalc?.num1 = nil
            intermediateCalc?.calcMethod = nil
            return 0
        case "+/-":
            intermediateCalc?.calcMethod = nil
            return n * -1
        case "%":
            intermediateCalc?.calcMethod = nil
            return n * 0.01
        case "=":
            let result = performCalculation(n2: n)
                intermediateCalc?.num1 = nil
                intermediateCalc?.calcMethod = nil
            return result
        default:
            if intermediateCalc?.num1 == nil || intermediateCalc?.calcMethod == nil{
                intermediateCalc = (num1: n, calcMethod : symbol)
            }else{
                let result = performCalculation(n2: n)
                intermediateCalc?.num1 = result
                return result
            }
        }
        }else {
            intermediateCalc?.calcMethod = nil
        }
        return nil
    }
    
    private func performCalculation(n2 : Double) -> Double? {
        if let n1 = intermediateCalc?.num1, let sym = intermediateCalc?.calcMethod {
            switch sym{
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                guard n2 != 0 else {return nil}
                return n1 / n2
            default:
                return nil
            }
        }
        return nil
    }
}
