//
//  Parser.swift
//  ScienceLexicon
//
//  Created by Rudd Fawcett on 1/26/16.
//  Copyright © 2016 Rudd Fawcett. All rights reserved.
//

import Foundation
import ObjectMapper

class Parser: NSObject {
    
    static func parse(file: String!) -> Lexicon? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "json") {
            let data = NSData.dataWithContentsOfMappedFile(path) as! NSData
            let json = String(data: data, encoding: NSUTF8StringEncoding)
            
            return Mapper<Lexicon>().map(json)
        }
        
        return nil
    }
    
}