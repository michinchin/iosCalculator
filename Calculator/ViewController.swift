import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var brain = CalculatorBrain()

    var userIsCurrentlyTyping = false
    var decimalPointButtonHasBeenPressed: Bool = false
    
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
    
  
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        let buttonText: String = sender.currentTitle!
        let currentText = display.text!

        if !currentText.contains("."){
            display.text = currentText + buttonText
        }
        userIsCurrentlyTyping = true

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
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    
    
  
    
    
    
}
