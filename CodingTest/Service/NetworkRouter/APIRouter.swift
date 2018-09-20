//
//  APIRouter.swift
//  CodingTest
//
//  Created by Prakash on 16/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias CustomHeaders = [String: String]

enum APIRouter:URLRequestConvertible{
   case search(name:String)
    // MARK: - HTTPMethod
   private var method: HTTPMethod {
        switch self {
        case .search:
            return .get
    }
}
    private var path: String {
        switch self {
      
        case .search(let OpName) :
            let searchString = OpName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            let Query = "action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=" + searchString + "+T&gpslimit=10"
            let newQueryString = Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            return newQueryString!
        }
    }
    func queryItems(dictionary: [String:Any]) -> String {
        var components = URLComponents()
        print(components.url!)
        components.queryItems = dictionary.map {
            URLQueryItem(name: $0, value: $1  as? String)
        }
        return (components.url?.absoluteString)!
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .search:
            return nil
        }
    }
    private var customHeaders : CustomHeaders? {
        switch self {
        case .search:
            return nil
        }
    }
    func asURLRequest() throws -> URLRequest {
        print("Base Url :: \(K.ServerURL.serverbaseURL)")
        // let pathMut = K.ServerURL.serverbaseURL + path.removingPercentEncoding!
        
        let pathMut = K.ServerURL.serverbaseURL + path.removingPercentEncoding!
      print("Final Url :: \(pathMut)")
        let url = try pathMut.asURL()
        var urlRequest =  URLRequest(url: url)
       print("Final UrlRequest :: \(urlRequest)")
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let heads = customHeaders {
            for (field, value) in heads {
                urlRequest.setValue(value, forHTTPHeaderField: field)
            }
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}


