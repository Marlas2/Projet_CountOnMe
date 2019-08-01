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
        calculator.addition()
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 + 1 = 2")
    }
    
    func testGivenAddNewNumber_WhenSoustractionIsTapped_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.soustraction()
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 - 1 = 0")
    }
    
    func testGivenAddNewNumber_WhenMultiplicationIsTapped_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.multiplication()
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 * 1 = 1")
    }
    
    func testGivenAddNewNumber_WhenDivisionIsTapped_ThenShowResult() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.division()
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculText, "1 / 1 = 1")
    }
    
    func testGivenCanAddNewNumber_WhenAdditionIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.addition()
        calculator.addition()
    }
    
    func testGivenCanAddNewNumber_WhenSoustractionIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.soustraction()
        calculator.soustraction()
    }
    
    func testGivenCanAddNewNumber_WhenMultiplicationIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.multiplication()
        calculator.multiplication()
    }
    
    func testGivenCanAddNewNumber_WhenDivisionIsTapped_ThenAddNewNumber() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.division()
        calculator.division()
    }
    
    func testGivenEqual_WhenEqualIsTappedTwice_ThenShowAlert() {
        calculator.addNewNumber(stringNumber: "1")
        calculator.equal()
        calculator.equal()
        XCTAssertTrue(calculator.expressionIsCorrect)
    }
    
    func testB() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.equal()
        XCTAssertTrue(calculator.expressionIsCorrect)
    }
    
    func testC() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.addition()
        calculator.equal()
    }
    
  /*  func testDivisionByZero() {
        calculator.addNewNumber(stringNumber: "2")
        calculator.division()
        calculator.addNewNumber(stringNumber: "0")
        calculator.equal()
        
    } */
}

