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
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert(notification:)), name: Notification.Name("ShowAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDisplay(notification:)), name: Notification.Name("UpdateDisplay"), object: nil)
    }
    
    @objc func updateDisplay(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let calculText = userInfo["calculText"] as? String else { return }
        textView.text = calculText
    }
    
    @objc func showAlert(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let message = userInfo["message"] as? String else { return }
        let alertVC = UIAlertController(title: "Attention !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNewNumber(stringNumber: numberText)
    }
    
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let currentOperator = sender.title(for: .normal) else { return }
        calculator.addOperator(currentOperator: currentOperator)
        
    }
    
    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculator.clear()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.equal()
    } 
}


