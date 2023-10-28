//
//  HomeViewController.swift
//  ECommerceAppProject
//
//  Created by amritansh kaushik on 04/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var catagoryTableView: UITableView!
    static var catagories: [Catagories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catagoryTableView.delegate = self
        catagoryTableView.dataSource = self
        
        catagoryTableView.register(UINib(nibName: "CatagoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CatagoriesTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchCatagories()
    }
    
    func fetchCatagories() {
        
        let url = URL(string: "https://fakestoreapi.com/products/categories")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error as Any)
                return
                
            }
            
            do {
                
                let cat = try JSONDecoder().decode([String].self, from: data!)
                for i in cat {
                    HomeViewController.catagories.append(Catagories(catagory: i))
                    DispatchQueue.main.async {
                        self.catagoryTableView.reloadData()
                    }
                }
            } catch {
                print("Error in fetching data in Catagory")
            }
            
        }
        task.resume()
    }
    
    func displayProducts(catagory: String) {
        switch catagory {
            
        case "electronics":
            let cat = "electronics"
            ProductViewController.selectedCatagory = cat
            
        case "jewelery":
            let cat = "jewelery"
            ProductViewController.selectedCatagory = cat
            
        case "men's clothing":
            let cat = "men's%20clothing"
            ProductViewController.selectedCatagory = cat
            
        case "women's clothing":
            let cat = "women's%20clothing"
            ProductViewController.selectedCatagory = cat
            
        default:
            SupportFiles.alertMessage(title: "Catagory Error", message: "", vc: self)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductVC")
        show(vc, sender: self)
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let catagory = HomeViewController.catagories[indexPath.row].catagory
            
            displayProducts(catagory: catagory!)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return HomeViewController.catagories.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = catagoryTableView.dequeueReusableCell(withIdentifier: "CatagoriesTableViewCell", for: indexPath) as! CatagoriesTableViewCell
            let fetchedCatagory = HomeViewController.catagories[indexPath.row].catagory
            
            switch fetchedCatagory {
            case "electronics":
                cell.catagoryImage.image = UIImage(named: "Electronics.png")
            case "jewelery":
                cell.catagoryImage.image = UIImage(named: "Jwellery.png")
            case "men's clothing":
                cell.catagoryImage.image = UIImage(named: "MenClothing.png")
            case "women's clothing":
                cell.catagoryImage.image = UIImage(named: "WomenClothing.png")
            default:
                cell.catagoryImage.image = UIImage(systemName: "questionmark.square.dashed")
            }
            
            return cell
    }
}

