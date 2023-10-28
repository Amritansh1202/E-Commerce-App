//
//  ProductViewController.swift
//  ECommerceAppProject
//
//  Created by amritansh kaushik on 04/05/23.
//

import UIKit


class ProductViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    
    static var selectedCatagory: String = ""
    static var productsArray: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsTableView.delegate = self
        productsTableView.dataSource = self

        productsTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchProducts()
    }
    override func viewWillDisappear(_ animated: Bool) {
        ProductViewController.productsArray = []
    }
    
    func fetchProducts() {
        
        let url = URL(string: "https://fakestoreapi.com/products/category/\(ProductViewController.selectedCatagory)")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error as Any)
                return
            }
            
            do {
                let prod = try JSONDecoder().decode([Products].self, from: data!)
                
                for i in prod {
                    ProductViewController.productsArray.append(ProductModel(id: i.id, title: i.title, price: Float(i.price), catagory: i.category, description: i.description, image: i.image))
                    DispatchQueue.main.async {
                        self.productsTableView.reloadData()
                    }
                }
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }

}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ProductViewController.productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        cell.productPriceLabel.text = "\(ProductViewController.productsArray[indexPath.row].price!)$"
        cell.productDescriptionLabel.text = ProductViewController.productsArray[indexPath.row].description
        cell.productNameLabel.text = ProductViewController.productsArray[indexPath.row].title
        
        
        let url = URL(string: ProductViewController.productsArray[indexPath.row].image!)
        
        DispatchQueue.global().async{
            let d = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.productImageView.image = UIImage(data: d!)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ProductDisplayViewController.selectedID = ProductViewController.productsArray[indexPath.row].id!
        ProductDisplayViewController.selectedDescription = ProductViewController.productsArray[indexPath.row].description!
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDisplayViewController")
        show(vc, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
