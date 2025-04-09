//
//  ViewController.swift
//  Calculator
//
//  Created by Danila on 21.10.2024.
//

import UIKit

enum OperationType: String {
    case plus = "+"
    case minus = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "C"
    
}


class ViewController: UIViewController {
    @IBOutlet var displayLabel: UILabel!
    private var leftOperand: Double?
    private var operation: OperationType?
    private var isTypingNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        guard let buttonText = sender.title(for:
                .normal)
        else {
            print("nil")
            return
        }
        
        if isTypingNumber {
            displayLabel.text = (displayLabel.text ?? "") + buttonText
        }
        else {
            displayLabel.text = buttonText
            isTypingNumber = true
        }
        
    }
    @IBAction func performOperation(_ sender: UIButton) {
        guard let operationText = sender.title(for: .normal),
              let operation = OperationType(rawValue: operationText)
        else {
            print("nil")
            return
        }
        if operation == .clear {
            clearCalculator()
            return
        }
        if let leftOperand = leftOperand,
           let displayText = displayLabel.text,
           let rightOperand = Double(displayText)
        {
            performOperation(operation: self.operation, lft: leftOperand, rgt: rightOperand)
        }
        
        //        if case .equal = operation,
        //           let existingOperation = self.operation,
        //           let leftOperand = leftOperand,
        //           let rightOperandText = displayLabel.text,
        //           let rightOperand = Int(rightOperandText)
        //        {
        //            performOperation(existingOperation, lft: leftOperand, rgt: rightOperand)
        //        }
        guard let leftOperandText = displayLabel.text,
              let leftOperand = Double(leftOperandText)
        else {
            return
        }
        self.leftOperand = leftOperand
        self.operation = operation
        isTypingNumber = false
        
        if operation == .equal {
            self.leftOperand = nil
            self.operation = nil
        }
        
        
        
    }
    private func performOperation(operation: OperationType?, lft: Double, rgt: Double) {
        
        guard let operation = operation else { return }
        
        var result: Double = 0
        
            
            switch operation {
            case .plus:
                result = lft + rgt
            case .minus:
                result = lft - rgt
            case .divide:
                if rgt != 0 {
                    result = lft / rgt
                }
                else {
                    displayLabel.text = "Error"
                    clearCalculator()
                    return
                }
            case .multiply:
                result = lft * rgt
                
            default:
                break
            }
        let result2: Int
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            result2 = Int(result)
            displayLabel.text = String(result2)
        }
        else {
            displayLabel.text = String(result)
        }
        
//            displayLabel.text = String(result)
            isTypingNumber = false
        }
        private func clearCalculator() {
            leftOperand = nil
            operation = nil
            displayLabel.text = "0"
            isTypingNumber = false
        }
}
