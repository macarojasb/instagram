//
//  PhotoDetailsViewController.swift
//  instagram
//
//  Created by Macarena Rojas on 2/11/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    
    var photoInfo: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photo = photoInfo
        let url = photo!["images"]!["low_resolution"]!!["url"] as! String
        let imageUrl = NSURL(string: url)
        
        picture.setImageWithURL(imageUrl!)
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
