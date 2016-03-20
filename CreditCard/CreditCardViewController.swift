//
//  CreditCardViewController.swift
//  CreditCard
//
//  Created by Sol Orive on 17/3/16.
//  Copyright © 2016 Sol Orive. All rights reserved.
//

import UIKit
import Alamofire


class CreditCardViewController: UITableViewController {
    
    var creditCard: [String]?
    var newArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /*
        let pm1 = PaymentMethod()
        pm1.name = "Visa"
        
        let pm2 = PaymentMethod()
        pm2.name = "MasterCard"
        
        let pm3 = PaymentMethod()
        pm3.name = "Tarjeta Naranja"
      */
        getArray()
       // print(self.newArray)
        creditCard = self.newArray
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let creditCard = creditCard {
            return creditCard.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CreditCardCell", forIndexPath: indexPath)
        if let creditCard = creditCard?[indexPath.row] {
           cell.textLabel?.text = creditCard
        }
        return cell
    }
    
    func getArray(){
        var jsonArray: NSArray?
        Alamofire
            .request(.GET,"https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88")
            .responseJSON{ response in
                if let jsonResponse = response.result.value {
                    jsonArray = jsonResponse as? NSArray
                    for item in jsonArray! {
                        if item["payment_type_id"] as! String == "credit_card" {
                            self.newArray.append(item["name"] as! String)
                        }
                    }
                    self.onComplete(self.newArray)
            }
        }
    }
    func onComplete(array: Array<String>){
        creditCard = array
        self.tableView.reloadData()
    }

}
