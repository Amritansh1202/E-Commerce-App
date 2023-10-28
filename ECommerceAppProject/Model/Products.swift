//
//  ProductModel.swift
//  ECommerceAppProject
//
//  Created by amritansh kaushik on 04/05/23.
//

import Foundation

struct Products : Codable {
    
    var id : Int
    var title : String
    var price : Double
    var category : String
    var description : String
    var image : String
}
