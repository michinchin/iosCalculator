//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Abigail Chin on 2/24/18.
//  Copyright © 2018 Abigail Chin. All rights reserved.
//

import Foundation

struct CalculatorBrain{
    var accumulator: Double?
    
    private var currentPendingBinaryOperation: PendingBinaryOperation?
    
    enum Operation {
        case constant(Double)
        case unaryOperation( (Double) -> Double )
        case binaryOperation( (Double,Double) -> Double )
        case equals
        case clear
    }
    
    
    var operations: [String: Operation] = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "∛": Operation.unaryOperation({pow($0, 1/3)}),
        "cos": Operation.unaryOperation(cos),
        "sin": Operation.unaryOperation(sin),
        "tan": Operation.unaryOperation(tan),
        "ln": Operation.unaryOperation(log),
        "log": Operation.unaryOperation({log10($0)}),
        "%": Operation.unaryOperation({$0 / 100}),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "−": Operation.binaryOperation({ $0 - $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "=": Operation.equals,
        "^": Operation.binaryOperation({pow($0, $1)}),
        "+/-": Operation.unaryOperation({ -$0 }),
        "C": Operation.clear
    ]
    
    mutating func performOperation(_ mathematicalSymbol: String) {
        if let operation = operations[mathematicalSymbol] {
            switch operation {
            case Operation.constant(let value):
                accumulator = value
            case Operation.unaryOperation(let function):
                if let value = accumulator {
                    accumulator = function(value)
                }
            case .binaryOperation(let function):
                if let firstOperand = accumulator {
                    currentPendingBinaryOperation = PendingBinaryOperation(firstOperand: firstOperand, function: function)
                    accumulator = nil
                }
            case .equals:
                performBinaryOperation()
                handleEqualOperation()
            case .clear:
                clearData()
            }
            
        }
    }
    
    mutating func handleEqualOperation(){
        if let value = accumulator{
            currentPendingBinaryOperation = PendingBinaryOperation(firstOperand: value, function: {_,_ in value})
        }
    }
    
    mutating func clearData(){
        accumulator = 0
        if let value = accumulator{
            currentPendingBinaryOperation = PendingBinaryOperation(firstOperand: value, function: {_,_ in value})
        }
    }
    
    mutating func performBinaryOperation() {
        if let operation = currentPendingBinaryOperation, let secondOperand = accumulator {
            accumulator = operation.perform(secondOperand: secondOperand)
        }
    }
    
  
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let function: (Double, Double) -> Double
        
        func perform(secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
}
