//
//  FeedViewController.swift
//  ExchangeAGram
//
//  Created by Ilian Jordanov on 10/15/14.
//  Copyright (c) 2014 ihjordanov. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    var feedArray:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        
        
        //let request = NSFetchRequest(entityName: "FeedItem")
        //let sortDescriptor = NSSortDescriptor(key: "caption", ascending: true)
        //request.sortDescriptors = [sortDescriptor]
        
        //let appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        //let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        //feedArray = context.executeFetchRequest(request, error: nil)!
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }
    
    
    @IBAction func profileTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("profileSegue", sender: nil)
    }
    
    
    @IBAction func snapBarItemButtonTyped(sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var cameraControler = 	UIImagePickerController()
            cameraControler.delegate = self
            cameraControler.sourceType = UIImagePickerControllerSourceType.Camera
            
            let mediaTypes: [AnyObject] = [kUTTypeImage]
            cameraControler.mediaTypes = mediaTypes
            cameraControler.allowsEditing = false
            
            self.presentViewController(cameraControler, animated: true, completion: nil)
            
            
        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var photoLibraryControler = UIImagePickerController()
            photoLibraryControler.delegate = self
            photoLibraryControler.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            let mediaTypes: [AnyObject] = [kUTTypeImage]
            photoLibraryControler.mediaTypes = mediaTypes
            photoLibraryControler.allowsEditing = false
            
            
            
            self.presentViewController(photoLibraryControler, animated: true, completion: nil)
            
            
        } else {
            var alertView = UIAlertController(title: "Alert", message: "Your device does not support camera nad photo library!", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            
            self.presentViewController(alertView, animated: true, completion: nil)
            
        }
    }
    
    //UIimagePickerControllerDelegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let thumbNailData = UIImageJPEGRepresentation(image, 0.1)
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("FeedItem", inManagedObjectContext: managedObjectContext!)
        
        let feedItem = FeedItem(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        feedItem.image = imageData
        feedItem.original = imageData
        feedItem.caption = ""
        feedItem.thumbNail = thumbNailData
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        
        //feedArray.append(feedItem)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        collectionView.reloadData()
    }
    
    // UICollectionVewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultController.sections![section].numberOfObjects
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: FeedCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FeedCell
        //let thisItem = feedArray[indexPath.row] as FeedItem
        var thisItem = fetchedResultController.objectAtIndexPath(indexPath) as FeedItem
        
        cell.imageView.image = UIImage(data: thisItem.image)
        cell.captionLabel.text = thisItem.caption
        cell.indexPath = indexPath
        cell.feedVC = self
        
        return cell
    }
    
    //UICollectionViewDelegates
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // let thisItem = feedArray[indexPath.row] as FeedItem
        let thisItem = fetchedResultController.objectAtIndexPath(indexPath) as FeedItem
        
        var filterVC = FilterViewController()
        filterVC.thisFeedItem = thisItem
        filterVC.thisFeedIndex = indexPath.row
        
        self.navigationController?.pushViewController(filterVC, animated: false)
        
    }
    
    //UICoreDataEvents
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        collectionView.reloadData()
    }
    
    // Helpers
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "FeedItem")
        let sortDescriptor = NSSortDescriptor(key: "caption", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func deleteCoreOBjectByIndex(indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath as NSIndexPath) as NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
        
        
    }
    
}
