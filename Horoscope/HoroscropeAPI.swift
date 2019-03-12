//
//  HoroscropeAPI.swift
//  Horoscope
//
//  Created by Aigars Silavs on 11/03/2019.
//  Copyright © 2019 Printful, Inc. All rights reserved.
//

import Foundation

let horoscopeAPI = HoroscopeAPI.sharedInstance

//https://github.com/sandipbgt/theastrologer-api

class HoroscopeAPI {
    
    enum Error: Swift.Error {
        case emptyResponse
        case invalidResponse
    }
    
    static let sharedInstance = HoroscopeAPI()
    
    let urlSession = URLSession(configuration: .default)
    
    func horoscope(forSunsign sunsign: Sunsign, withCompletion completion: @escaping (Horoscope?, Swift.Error?) -> Void) {
        
        let urlString = "https://horoscope-api.herokuapp.com/horoscope/today/\(sunsign.rawValue.capitalized)"
        let url = URL(string: urlString)!
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            //sleep(2)
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion(nil, HoroscopeAPI.Error.emptyResponse)
                    return
                }
                guard let horoscope = Horoscope(json: json) else {
                    completion(nil, HoroscopeAPI.Error.invalidResponse)
                    return
                }
                completion(horoscope, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
}
