//
//  APIManager.swift
//  Emir's Interest Rates App
//
//  Created by Emir TAŞÇAKIR on 24.08.2023.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    private let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "apikey 5NEcBNGgYQiHnfuA107TTE:7COO83FS4vJ5A3r0TdIBKY"
    ]
    
    func get(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        AF.request(url, headers: headers).response { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            
            if let data = response.data {
                completion(data, nil)
            }
        }
    }
}
