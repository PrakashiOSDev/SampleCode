//
//  constants.swift
//  CodingTest
//
//  Created by Prakash on 17/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import Foundation
import UIKit

let baseURL  = "https://en.wikipedia.org//w/api.php?"
let APP_DELEGATE : AppDelegate = UIApplication.shared.delegate as! AppDelegate

struct K {
    struct ServerURL {
        static let serverbaseURL = baseURL
    }
}
enum ContentType: String {
    case json = "application/json"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}
