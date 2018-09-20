//
//  APIClient.swift
//  CodingTest
//
//  Created by Prakash on 16/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

class APIClient{
    
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        // Create the server trust policies
        APIClient.bypassURLAuthentication()
        return Alamofire.request(route)
            .responseDecodableObject (decoder: decoder){ (response: DataResponse<T>) in
                if let data = response.data, let completeData = String(data: data, encoding: .utf8) {
                    let retainRoute = route
                    print("\n\n\n Response Received Data: \n \(completeData)\n\n\n")
                   
                }
                
                print("\n Request: \(String(describing: response.request))")
                print("\n Response: \(String(describing: response.response))")
                print("\n Response Result: \(String(describing: response.result))")
                print("\n Error: \(String(describing: response.error))")
                
                print("\n Error: \(String(describing: response.response?.statusCode))")
                
                
                completion(response.result)
        }
    }
    
    //MARK:- By-pass URL authentication, only for debug not release
    static func bypassURLAuthentication() {
        let manager = Alamofire.SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            return (disposition, credential)
        }
    }
    
    static func search(name:String,completion:@escaping (Result<SearchResults>)->Void){
        let _ = performRequest(route: APIRouter.search(name: name), completion: completion)
        
    }
    
}
