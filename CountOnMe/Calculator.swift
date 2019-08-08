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
    
    var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }
    
    var expressionHaveDivisionByZero: Bool {
        return (elements.firstIndex(of: "/") != nil) && elements.contains("0")
    }
    
    var expressionStartWithASign: Bool {
        return elements.first != "+" && elements.first != "-" && elements.first != "*" && elements.first != "/"
    }
    
    
    func clear() {
        calculText.removeAll()
    }
    
    func addNewNumber(stringNumber : String) {
        
        if expressionHaveResult {
            calculText = ""
        }
        
        calculText.append(stringNumber)
    }
    
    func addition() {
        
        if canAddOperator {
            calculText.append(" + ")
        } else {
            print("Un operateur est déja mis !")
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Un operateur est déja mis !"])
        }
    }
    
    func soustraction() {
        if canAddOperator {
            calculText.append(" - ")
        } else {
            print("Un operateur est déja mis !")
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Un operateur est déja mis !"])
        }
    }
    
    func multiplication() {
        if canAddOperator {
            calculText.append(" * ")
        } else {
            print("Un operateur est déja mis !")
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Un operateur est déja mis !"])
        }
    }
    
    func division() {
        if canAddOperator {
            calculText.append(" / ")
        } else {
            print("Un operateur est déja mis !")
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Un operateur est déja mis !"])
        }
    }
    
    func equal() {
        guard expressionIsCorrect else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Entrez une expression correcte !"])
            return
        }
        
        guard expressionHaveEnoughElement else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Démarrez un nouveau calcul !"])
            return
        }
        
        guard expressionStartWithASign else {
            NotificationCenter.default.post(name: Notification.Name("ShowAlert"), object: nil, userInfo: ["message":"Veuillez démarrer un nouveau calcul !"])
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




