//
//  ChangeUserViewController.swift
//  HttpRequests
//
//  Created by Jagadeesh on 30/12/21.
//

import UIKit

class ChangeUserViewController: UIViewController   {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
   
    
    var user: UserData!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        emailTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self

        updateButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        updateButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        idTextField.text = String(user.id)
        emailTextField?.text = user.email
        firstNameTextField?.text = user.first_name
        lastNameTextField?.text = user.last_name
        
    }

    @IBAction func DoneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(message: String) {
        let  alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler:  {  (action) in
           // print ("Perform Ok Action")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.show(alert, sender: nil)
        
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        //TODO: VALIDATE REQUIRED FIELDS
       
        let updatedUser = UserData(id: user.id, email: emailTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!)
        UserManager.shared.updateUserDetails(user: updatedUser) { (status) in
            if status {
              //show alert
                if (self.idTextField.text == "" ) {
                    self.showAlert(message: "Enter Valid Id")
                } else if  (self.emailTextField.text == "") {
                    self.showAlert(message: "Enter Valid Email")
                } else if (self.firstNameTextField.text == "" ) {
                    self.showAlert(message: "Enter valid FirstName")
                } else if (self.lastNameTextField.text == "") {
                    self.showAlert(message: "Enter Valid LastName")
                }  else {
                    self.showAlert(message: "Update Success")
                }
            } else {
                print("update failed")
                self.showAlert(message: "Update Failed")
            }
        }
        
    }
    

}

extension ChangeUserViewController: UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
        if textField == idTextField {
                   emailTextField.becomeFirstResponder()
               } else if textField == emailTextField {
                   firstNameTextField.becomeFirstResponder()
               } else if textField == firstNameTextField {
                   lastNameTextField.becomeFirstResponder()
               } else {
                   lastNameTextField.resignFirstResponder()
               }
        
            return true
    }
    
}




