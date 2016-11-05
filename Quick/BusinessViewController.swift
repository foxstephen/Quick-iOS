//
//  ViewController.swift
//  Quick-BusinessViewController
//
//  Created by Stephen Fox on 07/09/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit
import Cartography

/**
 This class presents info for a Business.
 */
class BusinessViewController: QuickViewController {
  
  var business: Business?
  // Shows products for the business.
  fileprivate var productsTableViewController: ProductsTableViewController!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.viewControllerBackgroundGray()
    self.setupViews()
  }

  
  // Sets up the UI
  fileprivate func setupViews() {
    
    // TODO: Make sure image can be still retrieved even if business was nil
    var businessImageView: BusinessImageView!
    if let business = self.business {
      businessImageView = BusinessImageView(businessName: business.name!,
                                                businessLocation: business.address!)
      self.view.addSubview(businessImageView)
      
      DispatchQueue.global().async {
        let url = URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/02/1c/85/db/front-door.jpg")
        let nsdata = try? Data.init(contentsOf: url!)
        DispatchQueue.main.async(execute: {
          let uiImage = UIImage(data: nsdata!)
          businessImageView.image = uiImage
        })
      }
    }
    
    let stripView = BusinessInfoStripView()
    self.view.addSubview(stripView)
    
    let seeProductsButton = BusinessSeeProductsButton()
    seeProductsButton.addTarget(self, action: #selector(showProductsViewController), for: .touchUpInside)
    self.view.addSubview(seeProductsButton)
    
    constrain(self.view, stripView, businessImageView, seeProductsButton) {
      (superView, stripView, businessImageView, seeProductsView) in
      
      businessImageView.leading == superView.leading
      businessImageView.trailing == superView.trailing
      businessImageView.top == superView.top
      businessImageView.height == superView.height * 0.4
      
      stripView.width == superView.width
      stripView.height == superView.height * 0.1
      stripView.top == businessImageView.bottom
      stripView.leading == superView.leading
      
      seeProductsView.width == superView.width
      seeProductsView.height == superView.height * 0.1
      seeProductsView.leading == superView.leading
      seeProductsView.trailing == superView.trailing
      seeProductsView.top == stripView.bottom + 10
    }
  }
  
  @objc fileprivate func showProductsViewController() {
    if self.productsTableViewController == nil {
      self.productsTableViewController = ProductsTableViewController()
    }
    self.productsTableViewController.business = self.business
    self.navigationController?.pushViewController(self.productsTableViewController, animated: true)
  }
}



