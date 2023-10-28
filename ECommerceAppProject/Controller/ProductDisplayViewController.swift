//
//  ProductDisplayViewController.swift
//  ECommerceAppProject
//
//  Created by amritansh kaushik on 04/05/23.
//

import UIKit

class ProductDisplayViewController: UIViewController {
    
    static var selectedID: Int = 0
    static var selectedDescription: String = ""

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProductWithID()
        self.productDescription.text = ProductDisplayViewController.selectedDescription
    }
    
    func fetchProductWithID()
    {
        let url = URL(string: "https://fakestoreapi.com/products/\(ProductDisplayViewController.selectedID)")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard error == nil else {
                print(error as Any)
                return
            }
            
            do {
                let product = try JSONDecoder().decode(Products.self, from: data!)
                
                let urlImage = URL(string: product.image)
                
                DispatchQueue.global().async{
                    let d = try? Data(contentsOf: urlImage!)
                    DispatchQueue.main.async {
                        self.productImage.image = UIImage(data: d!)
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.productTitle.text = product.title
                }
                
                    
                self.productPrice.text = "$\(product.price)"
                
                
            } catch {
                print("Error in ProductDisplayView Controller : \(error)")
            }
        }
        task.resume()
    }

    @IBAction func buyButtonPressed(_ sender: Any) {
        
    }
}
