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
    
    var creditCards: [String]?
    
    //TODO this should come from a config file.
    let baseUrl = "https://api.mercadopago.com/v1/"
    let publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
    let uri = "payment_methods"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiManager.sharedInstance.getPaymentMethods(self.baseUrl,uri: self.uri,publicKey: self.publicKey){ paymentMethods in
            var givenCreditCards:Array<String> = []
            
            for paymentMethod in paymentMethods {
                if paymentMethod["payment_type_id"] as! String == "credit_card" {
                    givenCreditCards.append(paymentMethod["name"] as! String)
                }
            }
            self.creditCards = givenCreditCards
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cards = creditCards {
            return cards.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CreditCardCell", forIndexPath: indexPath)
        if let card = creditCards?[indexPath.row] {
           cell.textLabel?.text = card
        }
        return cell
    }
}
