//
//  ItemCell.swift
//  Inventory
//
//  Created by Michael King on 4/3/16.
//  Copyright © 2016 Michael King. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class ItemCell: UITableViewCell {

    var item: Item!
    var request: Request?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var subCategoryLbl: UILabel!
    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var cartoonBoxClosed: UIImageView!
    @IBOutlet weak var boxNumberLbl: UILabel!
    @IBOutlet weak var imgFragile: UIImageView!
    @IBAction func boxNumberScanBtn(sender: AnyObject) {
        //open QR Reader to scan box number - add's box number as Item's keeper
        
    }
    
    @IBOutlet weak var boxNumberScanBtnLbl: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }//awakeFromNib
    
    
    func configureCell(item: Item, img: UIImage? ) {
        self.item = item
        
        self.nameLbl.text = item.itemName
        self.categoryLbl.text = "\(item.itemCategory!)"
        self.subCategoryLbl.text = "\(item.itemSubcategory!)"
   
        if item.itemBoxNum != nil {
            self.boxNumberScanBtnLbl.setTitle("\(item.itemBoxNum!)", forState: UIControlState.Normal)
            
        } else {
            
        //     self.boxNumberScanBtnLbl.setTitle("Add to Box", forState: UIControlState.Normal)
        }
        
        
    
        if item.itemImgUrl != nil {
            
            // if there's something here, load image from cache, or make request to go get image
            if img != nil {
                self.imageThumb.image = img
            } else {
                
                request = Alamofire.request(.GET, item.itemImgUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    
                    if err == nil {
                        let img = UIImage(data: data!)!  // Convert to image
                        self.imageThumb.image = img
                        itemFeedVC.imageCache.setObject(img, forKey: self.item.itemImgUrl!)   // save image to cache
                    }
                })
                
            }
            
        } else {
            self.imageThumb.hidden = true
        }
    

    
        //check if fragile, show image or don't
    
//        if item.itemFragile == false {
//            self.imgFragile.hidden = true
//        }//ifFragile
        
    }//ConfigureCell
    
    
    
    
    
}//ItemCell class









