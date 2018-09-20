//
//  SearchResults.swift
//  CodingTest
//
//  Created by Prakash on 16/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import Foundation

struct SearchResults:Decodable {
    var query:SearchQuery?
    
}
struct SearchQuery:Decodable{
    var pages:[SearchPages]?
    
}
struct SearchPages:Decodable {
    var title:String?
    var thumbnail:SearchDataThumbnail?
    var terms:SearchDataTerms?
    var index:Int?
}

struct SearchDataThumbnail:Decodable {
    var source:String?
    var width:Int?
    var height:Int?
}
struct SearchDataTerms:Decodable {
    var description:[String]?
}
