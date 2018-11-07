//
//  LBMaskTextField.swift
//  LBMaskTextField
//
//  Created by Lucas Bordini Ribeiro de Araujo.
//

import Foundation
import UIKit

class LBMaskTextField:NSObject, UITextFieldDelegate {
    
    var primaryMask: String = ""
    
    var maxLength: Int = 100
    
    var symbols: [String] = []
    
    var symbolsPosition: [Int] = []
    
    var usedSymbols: Int = 0
    
    var quantityOfSymbols: Int = 0
    
    var i: Int = 0
    
    var value: String = ""
    
    
    init(mask: String) {
        super.init()
        primaryMask = mask
        self.prepareMask()
        self.symbolsPosition.append(-1)
        self.symbols.append("")
    }
    
    func prepareMask() {
        self.maxLength = primaryMask.isEmpty ? 100 : primaryMask.count
        primaryMask.forEach { char in
            if char != "a" && char != "A" && char != "0" && char != "#" {
                self.prepareSymbols(String(char))
            }
            i += 1
        }
        
    }
    
    func prepareSymbols(_ char: String){
        symbols.append(String(char))
        symbolsPosition.append(i)
        quantityOfSymbols += 1
    }
    
    func addSymbolIfNeeded(_ position: Int) -> String {
        var text: String = ""
        if position == symbolsPosition[usedSymbols] {
            text += symbols[usedSymbols]
            usedSymbols += usedSymbols <= quantityOfSymbols ? 1 : 0
            let nextPosition = position + 1
            if nextPosition == self.symbolsPosition[usedSymbols] {
                text += addSymbolIfNeeded(nextPosition)
            }
        }
        return text
    }
    
    func removeSymbolIfNeeded(_ textField: UITextField) {
        let text = textField.text!
        let lenght = textField.valueLength()
        if ((!text.isEmpty) && (usedSymbols > 0) && (text[lenght - 1] == symbols[usedSymbols - 1])){
            textField.text!.removeLast()
            usedSymbols -= 1
            removeSymbolIfNeeded(textField)
        }
    }
    
    func removeChar(_ textField: UITextField){
        if (usedSymbols > 0){
            textField.text!.removeLast()
            removeSymbolIfNeeded(textField)
        } else {
            textField.text!.removeLast()
        }
    }
    
    func isPaste(text: String) -> Bool {
        return text.count > 1
    }
    
    func isNumber(char: String) -> Bool {
        return char.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var used = 0
        for i in 0..<textField.valueLength() {
            if self.symbolsPosition.contains(where: { p in p == i}) {
                used += 1
            }
        }
        self.usedSymbols = used
        var text = textField.text!
        if isPaste(text: string) { return false }
        if string.isEmpty {
            removeChar(textField)
            return false
        }
        if text.count == self.maxLength { return false }
        text += addSymbolIfNeeded(text.count)
        let index = text.count
        if primaryMask[index] == "a" && isNumber(char: string) { return false }
        if primaryMask[index] == "A" && isNumber(char: string) { return false }
        if primaryMask[index] == "0" && !isNumber(char: string) { return false }
        if primaryMask[index] == "A" { text += string.uppercased()}
        else { text += string }
        textField.text = text
        var arrayIndex: [String.Index] = []
        symbolsPosition.forEach({ p in
            guard let index = text.index(text.startIndex, offsetBy: p, limitedBy: text.endIndex) else { return }
            arrayIndex.append(index)
        })
        arrayIndex.reverse()
        arrayIndex.forEach({ ai in text.remove(at: ai)})
        value = text
        return false
    }
    
    func addTextManually(field: UITextField!, char: String){
        let range = NSRange.init(location: field.valueLength(), length: 1)
        _ = self.textField(field, shouldChangeCharactersIn: range, replacementString: char)
    }
    
    func getValue() -> String {
        return value
    }
    
}

extension String {
    
    subscript (i: Int) -> Character {
        if (i >= 0){
            return self[index(startIndex, offsetBy: i)]
        } else {
            return self[0]
        }
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}

extension UITextField {
    
    func valueLength() -> Int {
        if let text = self.text {
            return text.count
        } else {
            return 0
        }
    }
}

@IBDesignable class LBMaskedTextField: UITextField {
    
    @IBInspectable var textMask: String = ""
    var maskDelegate: LBMaskTextField?
    
    override func awakeFromNib() {
        maskDelegate = LBMaskTextField(mask: textMask)
        self.delegate = maskDelegate!
    }
    
    func getValue() -> String {
        return self.maskDelegate!.getValue()
    }
    
  
}
