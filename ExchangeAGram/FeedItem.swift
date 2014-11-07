//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by Ilian Jordanov on 10/30/14.
//  Copyright (c) 2014 ihjordanov. All rights reserved.
//

import Foundation
import CoreData

@objc(FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData
    @NSManaged var thumbNail: NSData
    @NSManaged var original: NSData

}
