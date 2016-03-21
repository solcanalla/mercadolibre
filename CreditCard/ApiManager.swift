//
//  ApiManager.swift
//  CreditCard
//
//  Created by Sol Orive on 20/3/16.
//  Copyright © 2016 Sol Orive. All rights reserved.
//

import Foundation
import Alamofire

typealias ServiceResponse = (NSArray) -> Void

class ApiManager : NSObject {
    
    static let sharedInstance = ApiManager()

    func getPaymentMethods(baseUrl: String, uri: String, publicKey: String, onCompletion: ServiceResponse) -> Void{
        
        let url = baseUrl + uri
        var paymentMethods: NSArray = []
        
        Alamofire
            .request(.GET, url ,parameters: ["public_key": publicKey])
            .response{ request,response,data,error in
                
                if((error) != nil){
                    print("API error")
                    // TODO It's necessary to do something when an error occurs?
                    print(error)
                }
                
            }
            .responseJSON{ response in
                if let jsonResponse = response.result.value {
                    if let pm  = jsonResponse as? NSArray{
                        paymentMethods = pm
                    
                    } else if let jR = jsonResponse as? NSDictionary{
                        // TODO This can be another flow maybe?
                        print(jR.valueForKey("message"))
                    }
                }
                onCompletion(paymentMethods)
            }
    }



}
