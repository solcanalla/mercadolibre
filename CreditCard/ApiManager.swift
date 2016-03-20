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
    
    class var sharedInstance:ApiManager {
        struct Singleton {
            static let instance = ApiManager()
        }
        return Singleton.instance
    }

    func getPaymentMethods(baseUrl: String, uri: String, publicKey: String, onCompletion: ServiceResponse) -> Void{
        
        let url = baseUrl + uri
        var paymentMethods: NSArray = []
        
        Alamofire
            .request(.GET, url ,parameters: ["public_key": publicKey])
            .response{ request,response,data,error in
                
                if((error) != nil){
                    print("API error")
                    print(error)
                }
                
            }
            .responseJSON{ response in
                if let jsonResponse = response.result.value {
                    if let pm  = jsonResponse as? NSArray{
                        paymentMethods = pm
                    }
                    
                    if (paymentMethods.count == 0){
                        // Logeo error.
                        print("No hay metodos de pagos asociados.")
                    }
                }
                onCompletion(paymentMethods)
            }
    }



}
