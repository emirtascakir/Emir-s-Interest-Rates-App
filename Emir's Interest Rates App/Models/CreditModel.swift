//
//  CreditModel.swift
//  Emir's Interest Rates App
//
//  Created by Emir TAŞÇAKIR on 24.08.2023.
//

import Foundation


struct CreditModel: Decodable {
    let success: Bool
    let result: [Result]
}

struct Result: Decodable {
    let bank, kredi, faiz, min, max: String
}
