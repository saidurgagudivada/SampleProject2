//
//  CreateUserViewController.swift
//  HttpRequests
//
//  Created by Jagadeesh on 03/01/22.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var CreateButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    var user = UserData?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        emailTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        CreateButton.layer.borderWidth = 1
        CreateButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        CreateButton.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func DoneButtonTapped(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    func showAlert(message: String)  {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler:
        {   (action)  in
                           }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.show(alert, sender: nil)
    }
    
    @IBAction func CreateButtonTapped(_ sender: Any) {
        let newUser = UserData(id: Int(idTextField.text!.trimmingCharacters(in: .whitespaces))!, email: emailTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!)
        UserManager.createNewUser(user: newUser) { (status) in
            if status  {
            if (self.idTextField.text == "") {
                    self.showAlert(message: "Enter Valid Id")
            } else if (self.emailTextField.text == "") {
                self.showAlert(message: "Enter Valid Email")
            } else if (self.firstNameTextField.text == "") {
                self.showAlert(message: "Enter Valid FirstName")
            } else if (self.lastNameTextField.text == "") {
                self.showAlert(message: "Enter Valid LastName")
            } else {
                print ("Create New User Successfully")
                self.showAlert(message: "Create New User Successfully")
            }
        } else {
                print("create New User Failed")
            self.showAlert(message: "create New User Failed")
            }
        }
    }

    
}

extension CreateUserViewController: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == idTextField   {
             emailTextField.becomeFirstResponder()
         }  else if textField == emailTextField  {
            firstNameTextField.becomeFirstResponder()
         }  else if textField == firstNameTextField  {
            lastNameTextField.becomeFirstResponder()
         }  else {
            lastNameTextField.resignFirstResponder()
        }
           return true
    }
    
}
