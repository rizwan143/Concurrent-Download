//
//  ViewController.swift
//  MultiThreadingTask
//
//  Created by Rizwan  Rana on 02/06/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

   
    //MARK: IBOutlet Properties
    @IBOutlet weak var firstImageProgressBar: UIProgressView!
    
    @IBOutlet weak var secondImageProgressBar: UIProgressView!
    
    @IBOutlet weak var thirdImageProgressBar: UIProgressView!
    
    var imagesArr = [UIImage()]
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: Button Action Methods
    @IBAction func downloadImagesClicked(_ sender: UIButton) {
        asyncApiCallForDownloadImages()
    }
    
  
    
    // Concurrent Thread along with download Images Asynchronously
    func asyncApiCallForDownloadImages() {
        let myQueue = DispatchQueue(label: "Concurrent Queue", attributes: .concurrent)
      //  "https://photojournal.jpl.nasa.gov/jpeg/PIA08506.jpg",
       // "http://placehold.it/120x120&text=image3",
      //  "http://placehold.it/120x120&text=image4"
        // API Call for Downloading Images
        // Image 1
        myQueue.async {
            self.downloadImageOne(urlString: "https://s3-us-west-2.amazonaws.com/uw-s3-cdn/wp-content/uploads/sites/6/2017/11/04133700/Discovery-Park-UW-Photo3.jpg")
        }
        
        // Image 2
        myQueue.async {
            self.downloadImageTwo(urlString: "https://s3-us-west-2.amazonaws.com/uw-s3-cdn/wp-content/uploads/sites/6/2017/11/04133712/waterfall.jpg")
        }
        
        // Image 3
        myQueue.async {
            self.downloadImageThree(urlString: "https://s3-us-west-2.amazonaws.com/uw-s3-cdn/wp-content/uploads/sites/6/2017/11/04133700/Discovery-Park-UW-Photo3.jpg")
        }
    }
    
    func downloadImageOne(urlString: String) {
        AF.download(urlString)
            .downloadProgress { progress in
                 print("Download Progress1: \(progress.fractionCompleted)")
                    self.firstImageProgressBar.progress = Float(progress.fractionCompleted)
             }

             .responseData { response in
                if case .success(let image) = response.result {
                    let downloadImage = UIImage(data: image)
                    self.imagesArr.append(downloadImage ?? UIImage())
                }
             }
    }
    
    func downloadImageTwo(urlString: String) {
        AF.download(urlString)
            .downloadProgress { progress in
                 print("Download Progress2: \(progress.fractionCompleted)")
                 self.secondImageProgressBar.progress = Float(progress.fractionCompleted)
             }

             .responseData { response in
                if case .success(let image) = response.result {
                    let downloadImage = UIImage(data: image)
                    self.imagesArr.append(downloadImage ?? UIImage())
                }
             }
    }
    
    func downloadImageThree(urlString: String) {
        AF.download(urlString)
            .downloadProgress { progress in
                 print("Download Progress3: \(progress.fractionCompleted)")
                 self.thirdImageProgressBar.progress = Float(progress.fractionCompleted)
             }

             .responseData { response in
                if case .success(let image) = response.result {
                    let downloadImage = UIImage(data: image)
                    self.imagesArr.append(downloadImage ?? UIImage())
                }
             }
        print(imagesArr)
    }
    
}

