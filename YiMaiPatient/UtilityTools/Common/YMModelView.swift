//
//  LoadingImage.swift
//  storyboard-try
//
//  Created by why on 16/5/13.
//  Copyright © 2016年 why. All rights reserved.
//

import Foundation
import Neon

public class YMPageLoading: NSObject {
    public let MaskBackground = UIView()
    private let LoadingView = UIActivityIndicatorView()
    private var ParentView: UIView? = nil
    
    private var AnimateDuration = 0.2
    
    public static let PageModalZPosition:CGFloat = 20.0
    public static let PageLoadingZPosition:CGFloat = 20.0
    public static let ControlLoadingZPosition:CGFloat = 10.0
    
    public init(parentView: UIView) {
        self.MaskBackground.alpha = 0.0
        self.MaskBackground.backgroundColor = UIColor.blackColor()
        self.MaskBackground.hidden = true
        self.MaskBackground.addSubview(self.LoadingView)
        
        self.ParentView = parentView
        parentView.addSubview(self.MaskBackground)
        
        self.LoadingView.startAnimating()
    }
    
    private func DoShowAnimate() {
        self.MaskBackground.alpha = 0.6
    }
    private func DoHideAnimate() {
        self.MaskBackground.alpha = 0
    }
    
    private func Hidden(finished: Bool){
        self.MaskBackground.hidden = true
    }
    
    public func Show(){
        self.MaskBackground.hidden = false
        UIView.animateWithDuration(AnimateDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: self.DoShowAnimate, completion: nil)
    }
    
    public func Hide(){
        UIView.animateWithDuration(AnimateDuration, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: self.DoHideAnimate, completion: self.Hidden)
    }
}

public class YMPageLoadingView: YMPageLoading {
    public override init(parentView: UIView) {
        super.init(parentView: parentView)

        self.MaskBackground.fillSuperview()
        self.LoadingView.anchorInCenter(width: self.LoadingView.width, height: self.LoadingView.height)
        MaskBackground.layer.zPosition = 10.0
    }
}

public class YMControlLoadingView: YMPageLoading {
    
    private var TargetView: UIView? = nil
    
    public init(parentView: UIView, target: UIView) {
        super.init(parentView: parentView)
        self.TargetView = target

        self.MaskBackground.layer.zPosition = YMPageLoading.ControlLoadingZPosition
        self.MaskBackground.frame = self.TargetView!.frame
        self.LoadingView.anchorInCenter(width: self.LoadingView.width, height: self.LoadingView.height)
    }
}

public typealias YMErrorAlertCallback = ((UIAlertAction) -> Void)
public typealias YMNormalAlertCallback = ((UIAlertAction) -> Void)
public class YMPageModalMessage {
    public static func ShowErrorInfo(info: String, nav: UINavigationController, callback: YMErrorAlertCallback? = nil) {
        let attributedString = NSAttributedString(string: info, attributes: [
            NSFontAttributeName: YMFonts.YMDefaultFont(24.LayoutVal())!, //your font here,
            NSForegroundColorAttributeName : YMColors.NotifyFlagOrange
            ])
        
        let alertController = UIAlertController(title: "", message: info, preferredStyle: .Alert)
        let okBtn = UIAlertAction(title: "确定", style: .Default, handler: callback)
        okBtn.setValue(YMColors.FontBlue, forKey: "titleTextColor")

        alertController.addAction(okBtn)
        alertController.setValue(attributedString, forKey: "attributedMessage")

        nav.presentViewController(alertController, animated: true, completion: nil)
    }
    
    public static func ShowNormalInfo(info: String, nav: UINavigationController, callback: YMNormalAlertCallback? = nil) {
        let attributedString = NSAttributedString(string: info, attributes: [
            NSFontAttributeName: YMFonts.YMDefaultFont(24.LayoutVal())!, //your font here,
            NSForegroundColorAttributeName : YMColors.FontLightGray
            ])
        
        let alertController = UIAlertController(title: "", message: info, preferredStyle: .Alert)
        let okBtn = UIAlertAction(title: "确定", style: .Default, handler: callback)
        okBtn.setValue(YMColors.FontBlue, forKey: "titleTextColor")
        
        alertController.addAction(okBtn)
        alertController.setValue(attributedString, forKey: "attributedMessage")
        
        nav.presentViewController(alertController, animated: true, completion: nil)
    }
}






































