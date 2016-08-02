//
//  ViewController.swift
//  Anyline Swift Example
//
//  Created by Matthias Gasser on 02/08/16.
//  Copyright © 2016 Anyline. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AnylineEnergyModuleDelegate {
    
    @IBOutlet weak var anylineEnergyView: AnylineEnergyModuleView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    let kAnylineKey = "eyJzY29wZSI6WyJBTEwiXSwicGxhdGZvcm0iOlsiaU9TIiwiQW5kcm9pZCIsIldpbmRvd3MiXSwidmFsaWQiOiIyMDE3LTA4LTAxIiwibWFqb3JWZXJzaW9uIjoiMyIsImlzQ29tbWVyY2lhbCI6ZmFsc2UsInRvbGVyYW5jZURheXMiOjYwLCJpb3NJZGVudGlmaWVyIjpbImlvLmFueWxpbmUuQW55bGluZS1Td2lmdC1FeGFtcGxlIl0sImFuZHJvaWRJZGVudGlmaWVyIjpbImlvLmFueWxpbmUuQW55bGluZS1Td2lmdC1FeGFtcGxlIl0sIndpbmRvd3NJZGVudGlmaWVyIjpbImlvLmFueWxpbmUuQW55bGluZS1Td2lmdC1FeGFtcGxlIl19ClpOVC8zYmxFOFVZUE55ZTZVdjAvbk5JMFFiME1oUnMvaFFBYVBEZGRiYUxZZG5OOTV5cGhZL2oydThwMUhQZjRZZysxSlN3Q3RBSHArNVZqK1Y4VjBHOGJTQU5VQ1dMaXFHNk45RzVTOWx3QXNpUjk1OEUvRDRBQitrVTRiakE1K0RCSGZtczVvSUtXZ3M4V2EzM2dxT0RxOExjZG1rcGgyK2k1UUFIVE9TemVQdlVxSEpMQjk4Y09EUXVVMnFDTEFxaTB2K0ZZZnd2M0pIQWl5MWtHVVBhRHBpNENBd3o3UXRYU2t1RzhWdDE0dG5NcUU0WDRLQ2FsS3VRcm5hdUhUcFBPT2VJK2s0dVIvaVQxeEE2MXI0cUI2VEprNHlIVFpVT2JjeFFqTld6bzdRa045bHptbEc5MFFBMXlLVnNMV0xqYlBCTUZlLzRaWVhueU5nL3pLUT09"
    @IBOutlet weak var resultImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try self.anylineEnergyView.setupWithLicenseKey(kAnylineKey, delegate: self)
        } catch let error as NSError {
            // we catch some common issues (wrong license, ... ) here
            let alertCtl = UIAlertController.init(title: "Setup Error", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.Alert)
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(alertCtl, animated: true, completion: nil)
            })
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
    
    //      dispatch_async(dispatch_get_main_queue(), {

        do {
            try self.anylineEnergyView.startScanning()
        } catch let error as NSError {
            
            print(error.userInfo)
            
            let alertCtl = UIAlertController.init(title: "Start Scanning Error", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.Alert)
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(alertCtl, animated: true, completion: nil)
            })
        }
//        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        do {
            try self.anylineEnergyView.cancelScanning()
        } catch {}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: AnylineEnergyModuleDelegate
    
    func anylineEnergyModuleView(anylineEnergyModuleView: AnylineEnergyModuleView!, didFindScanResult scanResult: String!, cropImage image: UIImage!, fullImage: UIImage!, inMode scanMode: ALScanMode) {
        // result will be here
        self.resultLabel.text = scanResult
        self.resultImage.image = image
        
    }
    

}

