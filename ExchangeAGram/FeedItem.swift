//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by Ilian Jordanov on 10/16/14.
//  Copyright (c) 2014 ihjordanov. All rights reserved.
//

import Foundation
import CoreData

@objc(FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
