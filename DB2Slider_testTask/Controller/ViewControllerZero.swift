//
//  ViewControllerZero.swift
//  DB2Slider_testTask
//
//  Created by Alex Berezovsky on 7/24/17.
//  Copyright © 2017 PatataMatata. All rights reserved.
//

import UIKit

class ViewControllerZero: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var collection: UICollectionView!
    
    var contacts = [ContactDetailsModel]()

    var swipeLeftGestureRecognizer: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initConfig()
        
        parseDialogs()

    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collection.dequeueReusableCell(withReuseIdentifier: "ContactDetailsCell", for: indexPath) as? ContactDetailsCell {
            
            let contactData: ContactDetailsModel! = self.contacts[indexPath.row]
            
            cell.configureCell(contactData)
            
            return cell
            
        } else {
            return  UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contact: ContactDetailsModel!
        
        contact = contacts[indexPath.row]
        
        performSegue(withIdentifier: "goToDialogDetailsVC", sender: contact)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return CGSize(width: self.view.frame.size.width, height: 100)
    }
    
    
    
    
    func initConfig() {

        self.collection.dataSource = self
        self.collection.delegate = self
        
        self.title = "Chats"
        
        self.swipeLeftGestureRecognizer.direction = .left

    }
    
    func parseDialogs() {
        
        if contacts.count == 0 {
            
            for _ in names {
                self.contacts += [ContactDetailsModel(profilePicture: "upic0"+String(self.contacts.count), name: names[contacts.count], shortMessage: dialogs[contacts.count], badgeInt: badgeCounts[contacts.count], date: dates[contacts.count], longDialog: dialogChain[contacts.count]/*, faceID: contacts.count*/)]
            }
        }
        
        self.collection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDialogDetailsVC" {
            
            if let detailsVC = segue.destination as? DialogDetailsVC {
                if let dialog = sender as? ContactDetailsModel {
                    detailsVC.contact = dialog
                    
                    print("імя будет ", dialog.name)
                }
            }
        }
    }
}
