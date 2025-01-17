//
//  CalculatorTests.swift
//  CountOnMeTests
//
//  Created by Quentin Marlas on 18/07/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//
@testable import CountOnMe
import XCTest

class CalculatorTests: XCTestCase {
    
    var calculator : Calculator!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = Calculator()
    }
    
    func testGivenAddNewNumber_WhenAdditionIsTapped_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "+")
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()

        XCTAssertEqual(calculator.calculText, "1 + 1 = 2.0")
    }
    
    func testGivenAddNewNumber_WhenSoustractionIsTapped_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "-")
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 - 1 = 0.0")
    }
    
    func testGivenAddNewNumber_WhenMultiplicationIsTapped_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "*")
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 * 1 = 1.0")
    }
    
    func testGivenAddNewNumber_WhenDivisionIsTapped_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "/")
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 / 1 = 1.0")
    }
    
    func testGivenCanAddNewNumber_WhenAdditionIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "+")
        calculator.addOperator(currentOperator: "+")    }
    
    func testGivenCanAddNewNumber_WhenSoustractionIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.addOperator(currentOperator: "-")
        calculator.addOperator(currentOperator: "-")
    }
    
    func testGivenCanAddNewNumber_WhenMultiplicationIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "*")
        calculator.addOperator(currentOperator: "*")
    }
    
    func testGivenCanAddNewNumber_WhenDivisionIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "/")
        calculator.addOperator(currentOperator: "/")
    }
    
    func testGivenEqual_WhenEqualIsTappedTwice_ThenShowAlert() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        calculator.equal()
        XCTAssertTrue(calculator.expressionIsCorrect)
    }
    
    func testGivenAddNewNumber_WhenExpressionIsCorrect_ThenIsTrue() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.equal()
        XCTAssertTrue(calculator.expressionIsCorrect)
    }
    
    func testGivenForAnError_WhenNoNumberAfterAnAddition_ThenShowAlert() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.addOperator(currentOperator: "+")
        calculator.equal()
    }
    
    func testGivenCalculWithPriorityOperators_WhenCalculate_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.addOperator(currentOperator: "+")
        calculator.addNewNumber(stringNumber: "2")
        calculator.addOperator(currentOperator: "/")
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "*")
        calculator.addNewNumber(stringNumber: "2")
        calculator.equal()
        
        XCTAssertTrue(calculator.expressionIsCorrect)
        XCTAssertTrue(calculator.expressionHaveResult)
        XCTAssertEqual(calculator.calculText, "2 + 2 / 1 * 2 = 6.0")
        
    }
    
    func testGivenDivisionByZero_WhenImpossible_ThenError() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "/")
        calculator.addNewNumber(stringNumber: "0")
        calculator.equal()
        XCTAssertFalse(calculator.expressionHaveResult)
    }
    
    func testGivenClear_WhenResetButtonIsTapped_ThenStartANewCalcul() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addOperator(currentOperator: "+")
        calculator.addNewNumber(stringNumber: "1")
        calculator.clear()
    }
    
    func testGivenStartWithASign_WhenButtonPlusIsTapped_ThenExpressionIsTested() {
        calculator.addOperator(currentOperator: "+")
        calculator.equal()
        XCTAssertTrue(calculator.expressionStartWithASign)
    }
    
    func testA() {
        calculator.addNewNumber(stringNumber: "")
        XCTAssertFalse(calculator.expressionHaveResult)
        XCTAssert(calculator.calculText == "")
    }
    
}

