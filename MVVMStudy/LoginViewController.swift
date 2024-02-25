//
//  LoginViewController.swift
//  MVVMStudy
//
//  Created by Madeline on 2/25/24.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let resultLabel = UILabel()
    
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "결과가 여기 나올 것임"

        configureView()
        
        viewModel.outputText.bind { value in
            self.resultLabel.text = value
        }
        
        viewModel.outputColor.bind { value in
            self.resultLabel.textColor = value ? .systemGreen : .systemRed
        }
        
        emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        
    }
    
    @objc func emailChanged() {
        guard let text = emailTextField.text else { return }
        viewModel.inputText.value = text
    }
    
    @objc func passwordChanged() {
        guard let text = passwordTextField.text else { return }
        viewModel.inputPassWord.value = text
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(resultLabel)
        
        emailTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(44)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(44)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(44)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(44)
        }
        
        emailTextField.backgroundColor = .systemGray6
        emailTextField.placeholder = "이메일을 입력해주세요."
        emailTextField.textColor = .white
        
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.placeholder = "비밀번호를 입력해주세요."
        passwordTextField.textColor = .white
    }
    
}

#Preview {
    LoginViewController()
}
