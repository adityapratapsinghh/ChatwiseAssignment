//
//  ViewController.swift
//  ChatwiseAssignment
//
//  Created by Aditya on 05/08/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    // Resuing the cell and displaying the data in the table
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.titleLabel.text = product.title
        cell.descriptionLabel.text = product.description
        if let url = URL(string: product.thumbnail) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.productImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    // When we click on any row in tableview, it will take to the product details page
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "showProductDetails", sender: selectedProduct)
    }
    // For passing data to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetails" {
            if let destinationVC = segue.destination as? ProductDetailsViewController, let product = sender as? Product {
                destinationVC.product = product
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        
        // Calling function when the view is loading
        fetchData()
        
    }
    
    
    // Function for fetching data from API and storing it in array
    
    func fetchData() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                    self.products = productsResponse.products
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
}

