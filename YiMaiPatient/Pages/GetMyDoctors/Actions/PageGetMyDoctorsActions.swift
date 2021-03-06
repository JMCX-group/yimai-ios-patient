//
//  PageGetMyDoctorsActions.swift
//  YiMaiPatient
//
//  Created by superxing on 16/9/9.
//  Copyright © 2016年 yimai. All rights reserved.
//

import Foundation
import UIKit

public class PageGetMyDoctorsActions: PageJumpActions {
    var MyDoctorApi: YMAPIUtility? = nil
    var TargetView: PageGetMyDoctorsBodyView? = nil
    var DeleteDoctorApi: YMAPIUtility!
    
    override public func ExtInit () {
        super.ExtInit()
        TargetView = self.Target as? PageGetMyDoctorsBodyView
        MyDoctorApi = YMAPIUtility(key: YMAPIStrings.CS_API_ACTION_GET_MY_DOCTOR,
                                   success: GetMyDoctorSuccess,
                                   error: GetMyDoctorError)
        
        DeleteDoctorApi = YMAPIUtility(key: YMAPIStrings.CS_API_ACTION_DELETE_MY_DOCOTOR, success: DeleteDocSuccess, error: DeleteDocError)
    }
    
    func DeleteDocSuccess(data: NSDictionary?) {
        print(data)
        TargetView?.MyDoctor = TargetView!.DoctorCacheForDelete
        TargetView?.LoadData(TargetView!.MyDoctor)
        TargetView?.FullPageLoading.Hide()

    }
    
    func DeleteDocError(error: NSError) {
        YMAPIUtility.PrintErrorInfo(error)
        YMPageModalMessage.ShowErrorInfo("网络繁忙，请稍后再试", nav: NavController!)
        TargetView?.DoctorCacheForDelete = TargetView!.MyDoctor
        TargetView?.LoadData(TargetView!.MyDoctor)
        TargetView?.FullPageLoading.Hide()
    }
    
    public func GetMyDoctorSuccess(data: NSDictionary?) {
        let realData = data!["data"] as! [[String: AnyObject]]
        TargetView?.LoadData(realData)
    }
    
    public func GetMyDoctorError(error: NSError) {
        YMAPIUtility.PrintErrorInfo(error)
        YMPageModalMessage.ShowErrorInfo("网络通讯故障，请稍后再试", nav: self.NavController!)
        TargetView?.FullPageLoading?.Hide()
    }

    public func SearchInputEnded (sender: YMTextField) {
        //TODO: 跳转到搜索页面
    }
    
    public func GetMyDoctorList () {
        MyDoctorApi?.YMGetMyDoctors()
    }
    
    public func DoctorTouched(gr: UIGestureRecognizer) {
        let doctorCell = gr.view as! YMScrollCell
        let doctorData = doctorCell.UserObjectData as! [String: AnyObject]
        
        TargetView?.LoadDoctorToBox(doctorData)
    }

    public func HideBox(gr: UIGestureRecognizer) {
        TargetView?.HideBox()
    }
    
    public func AppointmentTouched(sender: UIButton) {
        PageAppointmentViewController.SelectedDoctor = TargetView?.SelectedDoc
        PageAppointmentSelectTimeViewController.SelectedDoctor = TargetView?.SelectedDoc
        PageAppointmentViewController.ByPlatform = false
        DoJump(YMCommonStrings.CS_PAGE_APPOINTMENT_SELECT_TIME)
    }
    
    public func ProxyTouched(sender: UIButton) {
        PageAppointmentProxyViewController.SelectedDoctor = TargetView?.SelectedDoc
        PageAppointmentProxyViewController.NewAppointment = true
        DoJump(YMCommonStrings.CS_PAGE_APPOINTMENT_PROXY_NAME)
    }
}












