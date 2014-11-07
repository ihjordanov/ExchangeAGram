//
//  FeedCell.swift
//  ExchangeAGram
//
//  Created by Ilian Jordanov on 10/15/14.
//  Copyright (c) 2014 ihjordanov. All rights reserved.
//

import UIKit
import CoreData

class FeedCell: UICollectionViewCell, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var feedVC: FeedViewController!
    
    var indexPath: NSIndexPath!
    

    @IBAction func deleteButtonTyped(sender: AnyObject) {
        feedVC.deleteCoreOBjectByIndex(indexPath)
        
    }

}
