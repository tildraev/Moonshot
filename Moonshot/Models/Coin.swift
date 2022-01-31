//
//  Coin.swift
//  Moonshot
//
//  Created by Arian Mohajer on 1/31/22.
//

import Foundation

class Coin {
    var id: String
    var symbol: String
    var name: String
    
    init(id: String, symbol: String, name: String) {
        self.id = id
        self.symbol = symbol
        self.name = name
    }
}
