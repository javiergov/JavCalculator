//
//  CalculatorBrain.swift
//  JavCalculator
//
//  Created by Javier González Ovalle on 27-11-17.
//  Copyright © 2017 GOV Enjinia Works. All rights reserved.
//

import Foundation //UI independent, it's the model.
//Classes have inheritances, structs do not

func changeSign(operand : Double) -> Double {
    return -operand
}

func elevateByTwo(operand : Double) -> Double {
    return operand * operand
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
    }
    
    private var operations: Dictionary <String, Operation> = [
        "π" : Operation.constant(Double.pi),           //Double.pi,
        "e" : Operation.constant(M_E),           //M_E,
        "√" : Operation.unaryOperation(sqrt),    //sqrt,
      "cos" : Operation.unaryOperation(cos),
      "sin" : Operation.unaryOperation(sin),
        "∓" : Operation.unaryOperation(changeSign),
       "^2" : Operation.unaryOperation(elevateByTwo)
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value) :
                accumulator = value
                break // optional
            case .unaryOperation(let function) :
                if nil != accumulator {
                    accumulator = function(accumulator!)
                } else {
                    print("this var \(accumulator) is nil")
                }
                break
            }
        }
/*        switch symbol {
        case "π":
            accumulator = Double.pi //"3,1415926"
        case "√":
            if let operand = accumulator {
                accumulator = sqrt(operand)
            }
        case "^2":
            if let operand = accumulator {
                accumulator = operand * operand;
            }
        default:
            print("unknown operation \(symbol)")
        } */
    }
    
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? { //without set it becomes readonly
        get {
            return accumulator
        }
    }
    
}
