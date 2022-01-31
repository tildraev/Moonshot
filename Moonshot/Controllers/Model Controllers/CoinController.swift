//
//  CoinController.swift
//  Moonshot
//
//  Created by Arian Mohajer on 1/31/22.
//

import Foundation

class CoinController {
    
    static var coins: [Coin] = []
    private static var baseURLString: String = "https://api.coingecko.com/api/v3"
    private static var keyCoinsComponent: String = "/coins"
    private static var keyListsComponent: String = "/list"
    
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        guard let baseURL = URL(string: baseURLString) else { return completion(false)}
        var coinsURL = baseURL.appendingPathComponent(keyCoinsComponent)
        var finalURL = coinsURL.appendingPathComponent(keyCoinsComponent)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { coinData, _, error	 in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
                completion(false)
            } else {
                guard let data = coinData else { completion(false); return }
                do {
                    if let topLevelArrayOfCoinDictionaries = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:String]] {
                        for coinDictionary in topLevelArrayOfCoinDictionaries {
                            if let id = coinDictionary["id"],
                               let symbol = coinDictionary["symbol"],
                               let name = coinDictionary["name"] {
                                var parsedCoin = Coin(id: id, symbol: symbol, name: name)
                                coins.append(parsedCoin)
                            }
                        }
                    }
                    completion(true)
                } catch {
                    print("Error in do/try/catch: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }.resume()
        
    }
}
