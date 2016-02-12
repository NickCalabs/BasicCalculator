//
//  SecondViewController.swift
//  CalcTest
//
//  Created by Nick on 2/7/16.
//  Copyright © 2016 Nick. All rights reserved.
//

func add(a: Double, b: Double) -> Double {
    return a + b
}
func sub(a: Double, b: Double) -> Double {
    return a - b
}
func multiply(a: Double, b: Double) -> Double {
    return a * b
}
func divide(a: Double, b: Double) -> Double {
    return a / b
}

typealias operation = (Double, Double) -> Double
let operations: [String: operation] = ["+": add, "-": sub, "*": multiply, "/": divide]

import UIKit

class SecondViewController: UIViewController {
    
    var calcuated: Double = 0.0
    var input = ""
    
    var numberStack: [Double] = []
    var operationStack: [String] = []
    
    @IBOutlet weak var calcLabel: UILabel!
    
    @IBAction func digitButtonTapped(sender: AnyObject) {
        handleInput(sender.currentTitle)
    }
    
    @IBAction func calculationButtonTapped(sender: AnyObject) {
        calculate(sender.currentTitle)
    }
    
    @IBAction func equalsButtonTapped(sender: AnyObject) {
        equals()
    }
    
    @IBAction func plusMinusPressed(sender: AnyObject) {
        
    }
    
    @IBAction func percentageButtonPressed(sender: UIButton) {
        
    }
    
    @IBAction func ACPressed(sender: AnyObject) {
        input = ""
        calcuated = 0.0
        updateDisplay()
        numberStack.removeAll()
        operationStack.removeAll()
    }
    
    func handleInput(str: String?){
        input += str!
        calcuated = Double((input as NSString).doubleValue)
        updateDisplay()
    }
    
    func calculate(newOperation: String?){
        if input != "" && !numberStack.isEmpty {
            let stackOperation = operationStack.last
            if !((stackOperation == "+" || stackOperation == "-") && (newOperation == "*" || newOperation == "/")) {
                let operation = operations[operationStack.removeLast()]
                calcuated = operation!(numberStack.removeLast(), calcuated)
                equals()
            }
        }
        operationStack.append(newOperation!)
        numberStack.append(calcuated)
        input = ""
        updateDisplay()
    }
    
    func updateDisplay(){
        let fairband = Int(calcuated)
        if calcuated - Double(fairband) == 0{
            calcLabel.text = "\(fairband)"
        } else {
            calcLabel.text = "\(calcuated) test"
        }
    }
    
    func equals(){
        if input == "" {
            return
        }
        if !numberStack.isEmpty {
            let operation = operations[operationStack.removeLast()]
            calcuated = operation!(numberStack.removeLast(), calcuated)
            if !operationStack.isEmpty {
                equals()
            }
        }
        updateDisplay()
        input = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

