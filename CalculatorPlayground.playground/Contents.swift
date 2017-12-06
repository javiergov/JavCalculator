//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func changeSign (_ operand : Double) -> Double {
    return -operand
}

let i : Double = 72

var f: (Double) -> Double
f = changeSign

let x = f(i)




