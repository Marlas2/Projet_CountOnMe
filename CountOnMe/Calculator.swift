//
//  CountOnMeModel.swift
//  CountOnMe
//
//  Created by Quentin Marlas on 19/06/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    var calculText = "" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("UpdateDisplay"), object: nil, userInfo: ["calculText":calculText])
        }
    }
    //Split each elements
    var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    //Check if expression is correct or not
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    //Check if expression 3 or more elements
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    //Check if the sign equal is nil or not, if not expression have a result
    var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }
    
    //Check if the expression contain a "/", if yes and the elements after is à zero the division by zero is impossible
    var expressionHaveDivisionByZero: Bool {
        var tempElements = elements
        while tempElements.contains("/") {
            guard let index = tempElements.firstIndex(of: "/") else { return false }
            guard !(tempElements[index + 1] == "0") else { return true }
            tempElements[index] = String()
        }
        return false
    }
    
    //Check if the calcul start with an operatory sign or not
    var expressionStartWithASign: Bool {
        return elements.first == "-" || elements.first == "*" || elements.first == "/" || elements.first == "+"
    }
    
    //Function that clear all the current calcul
    func clear() {
        calculText.removeAll()
    }
    
    //Function to add a number in calcul text
    func addNewNumber(stringNumber : String) {
        
        if expressionHaveResult {
            calculText = ""
        }
        
        calculText.append(stringNumber)
    }
    
    //Function with a switch to chose the operatory sign to add. 2 operatory sign trigger an alert
    func addOperator(currentOperator: String) {
        if canAddOperator {
            switch currentOperator {
            case "/":
                calculText.append(" / ")
            case "*":
                calculText.append(" * ")
            case "+":
                calculText.append(" + ")
            case "-":
                calculText.append(" - ")
            default: break
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Un operateur est déja mis !"])
        }
    }
    
    
    //To show the result if all of this expressions are correct
    func equal() {
        
        guard !expressionStartWithASign else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Vous ne pouvez pas commencer une opération par un opérateur !"])
            return
        }
        
        guard expressionIsCorrect else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Entrez une expression correcte !"])
            return
        }
        
        guard expressionHaveEnoughElement else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Démarrez un nouveau calcul !"])
            return
        }
        
        guard !expressionHaveDivisionByZero else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Il est impossible de diviser par zéro !"])
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = priorityCalcul(operationsToReduce: elements)
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard let left = Double(operationsToReduce[0]) else { return }
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else { return }
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        guard let result = operationsToReduce.first else { return }
        calculText.append(" = \(result)")
    }
    
    // Function to calcul multiplication and division before addition and soustraction
    func priorityCalcul(operationsToReduce: [String]) -> [String] {
        var operations = operationsToReduce
        while operations.contains("*") || operations.contains("/"){
            if let index = operations.firstIndex(where: {$0 == "*" || $0 == "/"}){
                
                guard let firstSign = Double(operations[index - 1]) else { return [] }
                guard let secondSign = Double(operations[index + 1]) else { return [] }
                let operation = operations[index]
                
                var result = 0.0
                
                if operation == "*" {
                    result = firstSign * secondSign
                } else {
                    result = firstSign / secondSign
                }
                operations[index - 1] = String(result)
                operations.remove(at: index + 1)
                operations.remove(at: index)
            }
        }
        return operations
    }
}




