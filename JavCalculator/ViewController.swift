//
//  ViewController.swift
//  JavCalculator
//
//  Created by Javier González Ovalle on 07-11-17.
//  Copyright © 2017 GOV Enjinia Works. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel! // originally !
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var userIsCurrentlyWriting : Bool = false;
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!;
        
        if userIsCurrentlyWriting {
            print("digit \(digit) was touched");
            display.text = display.text! + digit
        }
        else {
            display.text = digit
            userIsCurrentlyWriting = true;
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsCurrentlyWriting = false;
        if let operationSign = sender.currentTitle {
            switch operationSign {
            case "π":
                displayValue = Double.pi //"3,1415926"
            case "√":
                displayValue = sqrt(displayValue)
                //                let operand = Double(display.text!)!
                //                display.text = String(sqrt(operand))
            case "^2":
                displayValue = displayValue * displayValue;
                
            default:
                print("unknown operation \(operationSign)")
            }
        }
    }
    
}

