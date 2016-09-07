//
//  Entry.swift
//  ScienceLexicon
//
//  Created by Rudd Fawcett on 1/26/16.
//  Copyright © 2016 Rudd Fawcett. All rights reserved.
//

import Foundation
import ObjectMapper

struct Entry: Mappable {
    var terms: [Language: String]! = [:]
    var definitions: [Language: String]! = [:]
    var citations: [String]?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        terms[Language.English]       <- map["terms.en"]
        terms[Language.Arabic]        <- map["terms.ar"]
        definitions[Language.English] <- map["definitions.en"]
        definitions[Language.Arabic]  <- map["definitions.ar"]
        citations                     <- map["citations"]
    }
}
