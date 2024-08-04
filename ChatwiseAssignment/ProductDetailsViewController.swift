//
//  ProductDetailsViewController.swift
//  ChatwiseAssignment
//
//  Created by Aditya on 05/08/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = product {
            titleLabel.text = product.title
            descriptionLabel.text = product.description
            if let url = URL(string: product.thumbnail) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.productImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
            priceLabel.text = "Price: \(product.price)"
        }
    }
    
}

