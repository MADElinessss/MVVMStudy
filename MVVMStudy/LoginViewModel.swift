//
//  LoginViewModel.swift
//  MVVMStudy
//
//  Created by Madeline on 2/25/24.
//

import Foundation

class LoginViewModel {
    
    var inputText = Observable("")
    var inputPassWord = Observable("")
    
    var outputText = Observable("")
    var outputColor = Observable(false)
    
    init() {
        inputText.bind { value in
            self.validation(email: value, pw: self.inputPassWord.value)
        }
        inputPassWord.bind { value in
            self.validation(email: self.inputText.value, pw: value)
        }
    }
    
    private func validation(email: String, pw: String) {
        if email.count >= 3 && pw.count > 5 {
            outputText.value = "\(email), \(pw)"
            outputColor.value = true
        } else {
            outputText.value = "3글자 이상 입력해주세요."
            outputColor.value = false
        }
    }
}
