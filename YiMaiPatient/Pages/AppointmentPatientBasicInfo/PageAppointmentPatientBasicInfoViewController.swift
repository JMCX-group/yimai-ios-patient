//
//  PageAppointmentPatientBasicInfoViewController.swift
//  YiMai
//
//  Created by ios-dev on 16/5/28.
//  Copyright © 2016年 why. All rights reserved.
//

import UIKit

public class PageAppointmentPatientBasicInfoViewController: PageViewController {
    private var Actions: PageAppointmentPatientBasicInfoActions? = nil
    public var BodyView: PageAppointmentPatientBasicInfoBodyView? = nil
    
    public override func PageLayout() {
        if(PageLayoutFlag) {return}
        PageLayoutFlag=true
        
        super.PageLayout()
        Actions = PageAppointmentPatientBasicInfoActions(navController: self.NavController, target: self)
        BodyView = PageAppointmentPatientBasicInfoBodyView(parentView: self.SelfView!, navController: self.NavController!, pageActions: Actions!)
        TopView = PageCommonTopView(parentView: self.SelfView!, titleString: "患者基本信息", navController: self.NavController!)
    }
}
