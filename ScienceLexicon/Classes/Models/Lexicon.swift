//
//  Lexicon.swift
//  ScienceLexicon
//
//  Created by Rudd Fawcett on 1/26/16.
//  Copyright © 2016 Rudd Fawcett. All rights reserved.
//

import Foundation
import ObjectMapper

struct Lexicon: Mappable {
    var topic: Topic!
    var entries: [Entry]!
    var indexed: [Language: [String: [Entry]]] = [:]
    var version: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        entries <- map["entries"]
        topic   <- (map["meta.topic"], EnumTransform<Topic>())
        version <- map["meta.version"]
        
        index(.English)
        index(.Arabic)
    }
    
    func alphabet(language: Language) -> String! {
        return language == .Arabic ? "ي و ه ن م ل ك ق ف غ ع ظ ط ض ص ش س ز ر ذ د خ ح ج ث ت ب ا" : "abcdefghijklmnopqrstuvwxyz";
    }
    
    mutating func alphabetize(language: Language) {
        entries = entries?.sort({
            $0.terms[language] < $1.terms[language]
        })
    }
    
    mutating func index(language: Language) {
        alphabetize(language)
        
        var data: [String: [Entry]] = [:]
        if entries?.count > 0 {
            for entry: Entry in entries! {
//                let key = language == .Arabic ? String(entry.terms[language]!.characters.last!) : String(entry.terms[language]!.characters.first!)
                let key = String(entry.terms[language]!.characters.first!).uppercaseString
                
                if var letter = data[key] {
                    letter.append(entry)
                    data.updateValue(letter, forKey: key)
                }
                else {
                    data.updateValue([entry], forKey: key)
                }
            }
        }
        
        indexed[language] = data
    }
}
