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
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsCurrentlyWriting {
            brain.setOperand(displayValue);
            userIsCurrentlyWriting = false;
        }

        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
}
