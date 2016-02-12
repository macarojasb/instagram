//
//  PhotosViewController.swift
//  instagram
//
//  Created by Macarena Rojas on 2/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking


class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

   
    @IBOutlet weak var tableView: UITableView!
    
        var photos : [NSDictionary]?
        var isMoreDataLoading = false

    
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            
            //Network request to instagram
            
            
            let clientId = "e05c462ebd86446ea48a5af73769b602"
            let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
            let request = NSURLRequest(URL: url!)
            let session = NSURLSession(
                configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
                delegate:nil,
                delegateQueue:NSOperationQueue.mainQueue()
            )
            
            let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
                completionHandler: { (dataOrNil, response, error) in
                    if let data = dataOrNil {
                        if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                            data, options:[]) as? NSDictionary {
                                NSLog("response: \(responseDictionary)")
                                
                                self.photos = responseDictionary["data"] as! [NSDictionary]?
                                
                                
                             
                                self.tableView.reloadData()

                                
                                
                        }
                    }
            });
            task.resume()
            
          tableView.rowHeight = 320
            
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let photos = self.photos {
            return photos.count;
        } else {
            return 0;        }
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
     let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! TableViewCell
        
        let photo = self.photos![indexPath.row]
        let url = photo["images"]!["low_resolution"]!!["url"] as! String
        let imageUrl = NSURL(string: url)
    
        cell.posterView.setImageWithURL(imageUrl!)
        
        return cell

    }
        // Do any additional setup after loading the view.

    
    func loadMoreData () {
    
        //Load more data
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.isMoreDataLoading = false

                            
                            self.photos = responseDictionary["data"] as! [NSDictionary]?
                            
                            self.tableView.reloadData()
                            
                            
                            
                    }
                }
        });
        task.resume()
    }
        
        func scrollViewDidScroll(scrollView: UIScrollView) {
            
            if (!isMoreDataLoading) {
                // calculate position
                
                let scrollViewContentHeight = self.tableView.contentSize.height
                let scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height
                
                if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.dragging) {
                    
                    isMoreDataLoading = true
                    
                    loadMoreData()
                    
                    
                }
                
                
            }
            
        }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
      
        let photoInfo = self.photos![(indexPath!.row)]
        
        vc.photoInfo = photoInfo
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TableViewCell
        
        cell.selectionStyle = .None

        
    }
    

}
