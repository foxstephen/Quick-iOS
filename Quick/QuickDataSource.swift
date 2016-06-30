//
//  QuickDataSource.swift
//  Quick
//
//  Created by Stephen Fox on 30/06/2016.
//  Copyright © 2016 Stephen Fox. All rights reserved.
//

import UIKit

/**
 Abstract class for independant data source objects.
 Subclassing allows for a clear interface between outside
 clients and the datasource.
 Due to the tight intergration between a UITableView object
 and its datasource, there's no real way of asking the datasource
 for data, subclassing this class, exposes an interface that
 makes data retrival from the datasource possible.
 */
class QuickDataSource: NSObject {
  func itemForRowIndex(indexPath: NSIndexPath) -> AnyObject? { return nil }
}
