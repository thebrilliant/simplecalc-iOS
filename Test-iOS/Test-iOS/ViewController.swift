//
//  ViewController.swift
//  Test-iOS
//
//  Created by Vivyan Woods on 10/21/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var num: String! = ""
    var actionPressed: Bool = false
    var clickedAction: String = ""
    var total: Double = 0.0
    var isFactorial = false
    
    var numbers: [Double] = []
    var actions: [String] = []
    
    @IBOutlet weak var resultLabel: UILabel!
    
    // resets all values to original state
    @IBAction func reset(sender: UIButton) {
        num = ""
        actionPressed = false
        clickedAction = ""
        total = 0.0
        isFactorial = false
        numbers.removeAll()
        actions.removeAll()
        
        resultLabel!.text = "0"
    }
    
    //calculates addition
    func add(currentSum:Double!, newVal:Double!) -> Double {
        return currentSum + newVal
    }
    
    //calculates subtraction
    func subtract(currentSum:Double!, newVal:Double!) -> Double {
        
        return currentSum - newVal
    }
    
    //calculates division
    func divide(currentSum:Double!, newVal:Double!) -> Double {
        if newVal == 0 {
            resultLabel!.text = "SYNTAX ERROR"
        }
        return (currentSum / newVal)
    }
    
    //calculates multiplcation
    func multiply(currentSum:Double!, newVal:Double!) -> Double {
        return currentSum * newVal
    }
    
    //calculates mod
    func mod(currentSum:Double!, newVal:Double!) -> Double {
        if newVal == 0 {
            resultLabel!.text = "SYNTAX ERROR"
        }
        return currentSum % newVal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numPress(sender: UIButton) {
        let text = sender.titleLabel!.text!
        if resultLabel != nil && !isFactorial {
            if actionPressed {
                num! = ""
                actionPressed = false
            }
            num! = num! + text
            resultLabel!.text = num
        } else if resultLabel != nil && isFactorial {
            reset(sender)
            resultLabel!.text = "SYNTAX ERROR"
        }
    }

    @IBAction func actionPress(sender: UIButton) {
        let action = sender.titleLabel!.text!
        numbers.append(Double(num!)!)
        actionPressed = true
        if actions.count == 0 {
            total = numbers[0]
        }
        switch action {
        case "fact (!)":
            isFactorial = true
            actions.append(action)
            if num!.containsString(".") {
                reset(sender)
                resultLabel!.text = "SYNTAX ERROR"
            }
        default:
            actions.append(action)
        }
        
    }
    
    @IBAction func equals(sender: UIButton) {
        actionPressed = false
        numbers.append(Double(num!)!)
        if numbers.count <= actions.count {
            reset(sender)
            resultLabel!.text = "SYNTAX ERROR"
        } else {
            var regular = false
            var seen = false
            for op in actions {
                var current = op
                switch current {
                case "avg", "count", "fact (!)":
                    seen = true
                default:
                    if seen {
                        regular = false
                    } else {
                        regular = true
                    }
                }
            }
            
            if regular {
                numbers.removeFirst()
                for numb in numbers {
                    var curAction = actions[0]
                    switch curAction {
                    case "+":
                        total = add(total, newVal: numb)
                    case "-":
                        total = subtract(total, newVal: numb)
                    case "x":
                        total = multiply(total, newVal: numb)
                    case "/":
                        total = divide(total, newVal: numb)
                    case "%":
                        total = mod(total, newVal: numb)
                    default:
                        reset(sender)
                        resultLabel!.text = "SYNTAX ERROR"
                    }
                    actions.removeFirst()
                    
                }
            } else {
                var operation = actions[0]
                switch operation {
                case "avg":
                    for number in numbers {
                        total = add(total, newVal: number)
                    }
                    let count:String = "\(numbers.count).0"
                    let temp = Double(count)!
                    total = divide(total, newVal: temp)
                case "count":
                    let count:String = "\(numbers.count).0"
                    total = Double(count)!
                case "fact (!)":
                    var number:String = "\(numbers[0])"
                    number = number.substringToIndex(number.rangeOfString(".")!.startIndex)
                    let intNum = Int(number)!
                    var doubleVer = 1.0
                    total = 1.0
                    for i in 1...intNum {
                        total = total * (doubleVer)
                        doubleVer += 1.0
                    }
                default:
                    resultLabel!.text = "SYNTAX ERROR"
                }
            }
            
            resultLabel!.text = "\(total)"
        }
    }
}
