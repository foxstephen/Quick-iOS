//
//  JSONParser.swift
//  Quick
//
//  Created by Stephen Fox on 04/07/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import SwiftyJSON

class JSONParser {
  
  /**
   Parses JSON content from server side response.
   
   - parameter json: The json to parse.
   */
  static func parseProduct(json: JSON) -> Product {
    let product = Product()
    if let pJSON = json.dictionary {
      product.id =          pJSON["id"]?.stringValue
      product.name =        pJSON["name"]?.stringValue
      product.price =       pJSON["price"]?.stringValue
      product.description = pJSON["description"]?.stringValue
      product.businessID =  pJSON["business_id"]?.stringValue
    }
    return product
  }
  
  
  
  static func parseBusiness(json: JSON) -> Business {
    let business = Business()
    if let bJSON = json.dictionary {
      business.id =             bJSON["id"]?.stringValue
      business.name =           bJSON["name"]?.stringValue
      business.address =        bJSON["address"]?.stringValue
      business.contactNumber =  bJSON["contact_number"]?.stringValue
    }
    return business
  }
}
