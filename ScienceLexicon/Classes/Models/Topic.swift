//
//  Topic.swift
//  ScienceLexicon
//
//  Created by Rudd Fawcett on 1/26/16.
//  Copyright © 2016 Rudd Fawcett. All rights reserved.
//

import Foundation

enum Topic: RawRepresentable {
    case Biology, Physics
    
    typealias RawValue = String
    
    var rawValue: RawValue {
        return self == .Biology ? "Biology" : "Physics"
    }
    
    init?(rawValue: RawValue) {
        self = rawValue == "Biology" ? .Biology : .Physics
    }
}
