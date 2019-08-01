//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    let calculator = Calculator()
    
    /*  var elements: [String] {
     return textView.text.split(separator: " ").map { "\($0)" }
     } */
    
    // Error check computed variables
    //    var expressionIsCorrect: Bool {
    //        return elements.last != "+" && elements.last != "-"
    //    }
    //
    //    var expressionHaveEnoughElement: Bool {
    //        return elements.count >= 3
    //    }
    //
    //    var canAddOperator: Bool {
    //        return elements.last != "+" && elements.last != "-"
    //    }
    //
    //    var expressionHaveResult: Bool {
    //        return textView.text.firstIndex(of: "=") != nil
    //    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert(notification:)), name: Notification.Name("ShowAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDisplay(notification:)), name: Notification.Name("UpdateDisplay"), object: nil)
        //   let notificationCenter = NotificationCenter.default
        //  notificationCenter.addObserver(self, selector: #selector(tappedEqualButton), name:  object: nil)
        //  notificationCenter.addObserver(self, selector: #selector(tappedNumberButton), name:  object: nil)
    }
    @objc func updateDisplay(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let calculText = userInfo["calculText"] as? String else { return }
        textView.text = calculText
    }
    
    @objc func showAlert(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let message = userInfo["message"] as? String else { return }
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNewNumber(stringNumber: numberText)
        //        if expressionHaveResult {
        //            textView.text = ""
        //        }
        //
        //        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.addition()
        //        if canAddOperator {
        //            textView.text.append(" + ")
        //        } else {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            self.present(alertVC, animated: true, completion: nil)
        //        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.soustraction()
        //        if canAddOperator {
        //            textView.text.append(" - ")
        //        } else {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            self.present(alertVC, animated: true, completion: nil)
        //        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.multiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.division()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.equal()
        //        guard expressionIsCorrect else {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            return self.present(alertVC, animated: true, completion: nil)
        //        }
        //
        //        guard expressionHaveEnoughElement else {
        //            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
        //            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //            return self.present(alertVC, animated: true, completion: nil)
        //        }
        //
        //
        //        // Create local copy of operations
        //        var operationsToReduce = elements
        //
        //        // Iterate over operations while an operand still here
        //        while operationsToReduce.count > 1 {
        //            let left = Int(operationsToReduce[0])!
        //            let operand = operationsToReduce[1]
        //            let right = Int(operationsToReduce[2])!
        //            
        //            let result: Int
        //            switch operand {
        //            case "+": result = left + right
        //            case "-": result = left - right
        //            default: fatalError("Unknown operator !")
        //            }
        //
        //            operationsToReduce = Array(operationsToReduce.dropFirst(3))
        //            operationsToReduce.insert("\(result)", at: 0)
        //        }
        //
        //        textView.text.append(" = \(operationsToReduce.first!)")
    }
}


