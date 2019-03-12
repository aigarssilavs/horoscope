//
//  Sunsign.swift
//  Horoscope
//
//  Created by Aigars Silavs on 11/03/2019.
//  Copyright © 2019 Printful, Inc. All rights reserved.
//

import Foundation

enum Sunsign: String {
    
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces
    
    var symbol: String {
        get {
            switch self {
            case .aries: return "♈"
            case .taurus: return "♉"
            case .gemini: return "♊"
            case .cancer: return "♋"
            case .leo: return "♌"
            case .virgo: return "♍"
            case .libra: return "♎"
            case .scorpio: return "♏"
            case .sagittarius: return "♐"
            case .capricorn: return "♑"
            case .aquarius: return "♒"
            case .pisces: return "♓"
            }
        }
    }
    
    static let all: [Sunsign] = [.aries, .taurus, .gemini,
                                 .cancer, .leo, .virgo,
                                 .libra, .scorpio, .sagittarius,
                                 .capricorn, .aquarius, .pisces]
}
