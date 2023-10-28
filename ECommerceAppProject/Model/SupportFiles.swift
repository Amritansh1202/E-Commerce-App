//
//  SupportFiles.swift
//  ECommerceAppProject
//
//  Created by amritansh kaushik on 02/05/23.
//

import UIKit

struct SupportFiles {
    
    static func alertMessage(title: String, message: String, vc: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
    
}
