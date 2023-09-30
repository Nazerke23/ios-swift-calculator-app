//
//  calcModel.swift
//  CalculatorApp
//
//  Created by Назерке Кулан on 19.09.2021.
//

import Foundation

struct CalculatorModel{
    
    var result: Double?{
        get{
            return global_value
        }
    }
    
    private var global_value: Double?
    
    enum Operation{
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double, Double)->Double)
        case equals
    }
    
    func addition(op1: Double, op2: Double)->Double{
        return op1+op2
    }
    
    var my_operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "=" : Operation.equals,
//        "+" : Operation.binaryOperation({( op1: Double, op2: Double) in return op1+op2})
        "+" : Operation.binaryOperation({$0 + $1}),
        "-" : Operation.binaryOperation({$0 - $1}),
        "x" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        
    ]
    
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    
    private var saving: SaveFirstOperandAndOperation?
    
    mutating func performOperation(_ operation: String){
        
        let symbol = my_operations[operation]!
        
        switch symbol {
        case .constant(let value):
            global_value = value
        case .unaryOperation(let function):
            global_value = function(global_value!)
        case .binaryOperation(let function):
            saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
        case .equals:
            if global_value != nil{
                global_value = saving?.performOperationWith(secondOperand: global_value!)
            }
        }
    }
    
    
    
    struct SaveFirstOperandAndOperation {
        var firstOperand: Double
        var operation: (Double, Double)-> Double
        
        func performOperationWith(secondOperand op2: Double)-> Double{
            return operation(firstOperand, op2)
        }
    }
    
}
