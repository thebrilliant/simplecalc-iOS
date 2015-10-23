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
    //var output = ""
    
    var numbers: [Double] = []
    var actions: [String] = []
    
    @IBOutlet weak var resultLabel: UILabel!
    
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
            return currentSum
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
            return currentSum
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
            //numbers.append(Double(num!)!)
            resultLabel!.text = num
        } else if resultLabel != nil && isFactorial {
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
                resultLabel!.text = "SYNTAX ERROR"
                numbers.removeLast()
            }
        default:
            actions.append(action)
        }
        
    }
    
    @IBAction func equals(sender: UIButton) {
        actionPressed = false
        numbers.append(Double(num!)!)
        if numbers.count <= actions.count {
            resultLabel!.text = "SYNTAX ERROR"
        }
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
        //var text: String = ""
        //var count = 0
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
                    resultLabel!.text = "SYNTAX ERROR"
                }
                actions.removeFirst()
                //text += "\(numbers.count) + "
                
            }
        } else {
            var operation = actions[0]
            switch operation {
            case "avg":
                //resultLabel!.text = operation
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
                    //multiply(total, newVal: (i + 0.0))
                }
            default:
                resultLabel!.text = "SYNTAX ERROR"
            }
        }
        
        resultLabel!.text = "\(total)"
    }
}


/*num! = num! + text
resultLabel!.text = num
//NSLog("num = \(num!)")
} else if resultLabel != nil && actionPressed {
num! = text
resultLabel!.text = num*/

/*if actionPressed {
actionPressed = false
switch clickedAction {
case "+", "-", "/", "x", "count", "avg", "fact (!)", "%":
switch clickedAction {
default:
resultLabel!.text = "SYNTAX ERROR"
}
default:
resultLabel!.text = "SYNTAX ERROR"
}
} else {
actionPressed = true
switch action {
case "+", "-", "/", "x", "count", "avg", "fact (!)", "%":
if clickedAction == "" {
total = add(total, newVal: Double(num!)!)
} else {
switch action {
case "+":
total = add(total, newVal: Double(num!)!)
case "-":
total = subtract(total, newVal: Double(num!)!)
case "/":
total = divide(total, newVal: Double(num!)!)
case "x":
total = multiply(total, newVal: Double(num!)!)
default:
resultLabel!.text = "SYNTAX ERROR"
}
}
clickedAction = action
resultLabel!.text = "\(total)"
default:
resultLabel!.text = "SYNTAX ERROR"
}
}*/