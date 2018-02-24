import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var brain = CalculatorBrain()

    var userIsCurrentlyTyping = false

//    @IBAction func clearButton(_ sender: Any) {
//        display.text = "0"
//        userIsCurrentlyTyping = false
//    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        let buttonText: String = sender.currentTitle!
        
        if userIsCurrentlyTyping {
            let currentText = display.text!
            display.text = currentText + buttonText
        }else {
            display.text = buttonText
            userIsCurrentlyTyping = true
        }
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        userIsCurrentlyTyping = false
        brain.setOperand(displayValue)
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
//    func backspace(){
//        if var text = display.text{
//            let index = text.endIndex
//            text.remove(at: index)
//        }
//    }
//
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    
    
  
    
    
    
}
