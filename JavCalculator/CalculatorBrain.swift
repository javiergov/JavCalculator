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

func divide(num1: Double, num2 : Double) -> Double {
    return num1 / num2
}

func sumTwoNumbers(num1: Double, num2 : Double) -> Double {
    return num1 + num2
}

func substract(num1: Double, num2 : Double) -> Double {
    return num1 - num2
}


struct CalculatorBrain {
    
    private var accumulator: Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary <String, Operation> = [
        "π" : Operation.constant(Double.pi),           //Double.pi,
        "e" : Operation.constant(M_E),           //M_E,
        "√" : Operation.unaryOperation(sqrt),    //sqrt,
      "cos" : Operation.unaryOperation(cos),
      "sin" : Operation.unaryOperation(sin),
        "∓" : Operation.unaryOperation(changeSign),
       "^2" : Operation.unaryOperation(elevateByTwo),
       "×" : Operation.binaryOperation({(num1: Double, num2 : Double) -> Double in return num1 * num2 }),
        "+" : Operation.binaryOperation(sumTwoNumbers),
        "-" : Operation.binaryOperation(substract),
        "÷" : Operation.binaryOperation(divide),
        "=" : Operation.equals
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
                }
                break
                
            case .binaryOperation(let function) :
                if nil != accumulator {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                } else {
                    print("nada que hacer")
                }
                break
                
            case .equals :
                performPendingBinaryOperation()
                break
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation : PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function : (Double, Double) -> Double
        let firstOperand : Double
        
        func perform(with secondOperand : Double) -> Double {
            return function(firstOperand, secondOperand)
        }
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
