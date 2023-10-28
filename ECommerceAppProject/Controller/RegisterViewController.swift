//
//  RegisterViewController.swift
//  ECommerceAppProject
//
//  Created by amritansh kaushik on 02/05/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var confirmPasswordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        
        if nameLabel.text != "" && emailLabel.text != "", passwordLabel.text != "", confirmPasswordLabel.text != "" {
            if passwordLabel.text != confirmPasswordLabel.text {
                SupportFiles.alertMessage(title: "Passwords don't match", message: "Re-enter Passwords", vc: self)
            } else {
                createData()
            }
            
        } else {
            SupportFiles.alertMessage(title: "Enter all the fields", message: "Some fields are missing", vc: self)
        }
        
    }

}

extension RegisterViewController {
    
    func createData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(nameLabel.text, forKey: "name")
        user.setValue(emailLabel.text, forKey: "email")
        user.setValue(passwordLabel.text, forKey: "password")
    }
}
