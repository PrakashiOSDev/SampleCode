//
//  ActivityIndicator.swift
//  CodingTest
//
//  Created by Prakash on 17/09/18.
//  Copyright © 2018 Prakash. All rights reserved.
//

import UIKit
import Foundation

class ActivityIndicator: UIView {

        @IBOutlet weak var progressView: UIImageView!
        
        static let ProgressLoaderView : ActivityIndicator = UINib(nibName: "ActivityIndicator", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ActivityIndicator
        class func startLoader(_ text: String) {
            let progressView: ActivityIndicator? = self.ProgressLoaderView
            let mainWindow = APP_DELEGATE.window
            progressView?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat((mainWindow?.bounds.width)!), height: CGFloat((mainWindow?.bounds.height)!))
            mainWindow?.addSubview(progressView!)
            var rotationAnimation: CABasicAnimation?
            rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation?.toValue = Int(.pi * 2.0 * 2 * 0.6)
            rotationAnimation?.duration = 1
            rotationAnimation?.isCumulative = true
            rotationAnimation?.repeatCount = MAXFLOAT
            progressView?.progressView?.layer.add(rotationAnimation!, forKey: "rotationAnimation")
        }
        
        class func stopLoader() {
            let progressView: ActivityIndicator? = ProgressLoaderView
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                progressView?.alpha = 0
            }, completion: {(_ finished: Bool) -> Void in
                progressView?.removeFromSuperview()
                progressView?.alpha = 1
            })
        }
        
    }

