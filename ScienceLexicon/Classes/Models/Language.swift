//
//  Language.swift
//  ScienceLexicon
//
//  Created by Rudd Fawcett on 1/26/16.
//  Copyright © 2016 Rudd Fawcett. All rights reserved.
//

import Foundation

enum Language: CustomStringConvertible {
    case English, Arabic
    
    var description : String {
        switch self {
        case .English: return "English"
        case .Arabic:  return "Arabic"
        }
    }
    
    mutating func toggle() {
        switch self {
        case .Arabic:
            self = .English
        case .English:
            self = .Arabic
        }
    }
    
    func opposite() -> Language {
        return self == .Arabic ? .English : .Arabic;
    }
}