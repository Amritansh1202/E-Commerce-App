//
//  LoginViewController.swift
//  ECommerceAppProject
//
//  Created by amritansh kaushik on 03/05/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    
    
    @IBOutlet weak var passwordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        if isEmailAndPasswordCorrect() {
            
            performSegue(withIdentifier: "loginToHome", sender: self)
        }
        else {
            SupportFiles.alertMessage(title: "Email or password is incorrect", message: "Enter valid email or password", vc: self)
        }
    }

    func isEmailAndPasswordCorrect() -> Bool {
        
        let email = emailLabel.text
        let password = passwordLabel.text
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject] {
                
                print("iiii")
                if ((data.value(forKey: "email") as! String) == email) && ((data.value(forKey: "password") as! String) == password) {
                    print(data.value(forKey: "password") as! String)
                    return true
                }
            }
            
            
        } catch {
            print("failed")
        }
        return false
    }
}
