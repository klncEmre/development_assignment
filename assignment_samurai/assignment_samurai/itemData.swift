//
//  itemData.swift
//  assignment_samurai
//
//  Created by EMRE KILINC on 29.04.2022.
//

import Foundation
struct itemData: Decodable{
    let name: String
    let count: Int
    let items: [itemData]? // it can be Nil
    let price: Int? // it can be Nil
    
}
