//
//  Horoscope.swift
//  Horoscope
//
//  Created by Aigars Silavs on 11/03/2019.
//  Copyright © 2019 Printful, Inc. All rights reserved.
//

import Foundation

struct Horoscope {
    let sunsign: Sunsign
    let date: Date
    let description: String
    
    init?(json: [String: Any]) {
        
        guard let dateString = json["date"] as? String else {
            return nil
        }
        
        guard let description = json["horoscope"] as? String else {
            return nil
        }
        
        guard let rawSunsign = json["sunsign"] as? String else {
            return nil
        }
        
        guard let sunsign = Sunsign(rawValue: rawSunsign.lowercased()) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        self.sunsign = sunsign
        self.description = description
        self.date = date
    }
}
