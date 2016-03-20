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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCreditCardsFromApi(baseUrl, publicKey: publicKey)
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
    
    func getCreditCardsFromApi(baseUrl: String, publicKey: String){
        
        let url = baseUrl + "payment_methods"
        var givenCreditCards:Array<String> = []
        var paymentMethods: NSArray?

        Alamofire
            .request(.GET, url ,parameters: ["public_key": publicKey])
            .responseJSON{ response in
                if let jsonResponse = response.result.value {
                    paymentMethods = jsonResponse as? NSArray
                    for paymentMethod in paymentMethods! {
                        if paymentMethod["payment_type_id"] as! String == "credit_card" {
                            givenCreditCards.append(paymentMethod["name"] as! String)
                        }
                    }
                    self.refreshView(givenCreditCards)
            }
        }
    }
    
    func refreshView(data: Array<String>){
        creditCards = data
        self.tableView.reloadData()
    }

}
