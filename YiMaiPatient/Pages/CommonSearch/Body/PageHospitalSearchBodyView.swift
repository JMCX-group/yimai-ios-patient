//
//  PageHospitalSearchBodyView.swift
//  YiMai
//
//  Created by why on 16/6/15.
//  Copyright © 2016年 why. All rights reserved.
//

import Foundation
import Neon

public class PageHospitalSearchBodyView: PageBodyView {
    private var SearchInput: YMTextField? = nil
    private let InputPanel: UIView = UIView()
    
    private var SearchResultTable: YMTableView? = nil
    
    private var Loading: YMPageLoadingView? = nil
    
    private var SearchActions: PageHospitalSearchActions? = nil
    
    public static var HospitalSelected: AnyObject? = nil
    
    public override func ViewLayout() {
        SearchActions = PageHospitalSearchActions(navController: self.NavController, target: self)
        SearchResultTable = YMTableView(builer: self.DrawHospitalCell, subBuilder: nil, touched: SearchActions!.HospitalSelected)

        super.ViewLayout()
        DrawPageTop()
        
        Loading = YMPageLoadingView(parentView: BodyView)
        Loading?.MaskBackground.layer.zPosition = 1.0
        
        
        ShowInitHospitals()
    }
    
    public func DrawPageTop() {
        let inputParam = TextFieldCreateParam()
        inputParam.BackgroundColor = YMColors.White
        inputParam.Placholder = "输入医院名称"
        inputParam.FontSize = 26.LayoutVal()
        inputParam.FontColor = YMColors.FontBlue
        
        BodyView.addSubview(InputPanel)
        InputPanel.anchorToEdge(Edge.Top, padding: 0, width: YMSizes.PageWidth, height: 120.LayoutVal())

        SearchInput = YMLayout.GetTextFieldWithMaxCharCount(inputParam, maxCharCount: 20)
        InputPanel.addSubview(SearchInput!)
        
        SearchInput?.anchorToEdge(Edge.Left, padding: 30.LayoutVal(), width: 570.LayoutVal(), height: 60.LayoutVal())
        SearchInput?.layer.cornerRadius = 6.LayoutVal()
        SearchInput?.layer.masksToBounds
        SearchInput?.SetLeftPadding(66.LayoutVal(), leftPaddingImage: "CommonIconSearchHeader")

        SearchInput?.EditEndCallback = SearchActions!.StartSearch
        
        let manuallyInputButton = YMButton()
        manuallyInputButton.setTitle("没找到？", forState: UIControlState.Normal)
        manuallyInputButton.setTitleColor(YMColors.FontGray, forState: UIControlState.Normal)
        manuallyInputButton.titleLabel?.font = YMFonts.YMDefaultFont(26.LayoutVal())
        manuallyInputButton.sizeToFit()
        
        InputPanel.addSubview(manuallyInputButton)
        manuallyInputButton.align(Align.ToTheRightCentered,
            relativeTo: SearchInput!,
            padding: 30.LayoutVal(),
            width: manuallyInputButton.width,
            height: manuallyInputButton.height)
    }
    
    private func DrawHospitalCell(cell: YMTableViewCell, data: AnyObject?) {
        let realData = data as! [String: AnyObject]
        
        let cellHeight = 81.LayoutVal()
        
        cell.CellTitleHeight = cellHeight
        cell.CellFullHeight = cellHeight
        
        cell.CellData = data
        cell.frame = CGRectMake(0,0, YMSizes.PageWidth, cellHeight)

        let cellInner = UIView(frame: CGRect(x: 0,y: 0,width: YMSizes.PageWidth,height: cellHeight))
        let hospitalName = realData[YMCommonStrings.CS_API_PARAM_KEY_NAME] as! String
        
        let hospitalLabel = UILabel()
        hospitalLabel.text = hospitalName
        hospitalLabel.textColor = YMColors.FontGray
        hospitalLabel.font = YMFonts.YMDefaultFont(28.LayoutVal())
        hospitalLabel.sizeToFit()
        
        cellInner.addSubview(hospitalLabel)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = YMColors.DividerLineGray
        cellInner.addSubview(bottomLine)
        
        hospitalLabel.anchorToEdge(Edge.Left, padding: 40.LayoutVal(), width: 700.LayoutVal(), height: hospitalLabel.height)
        bottomLine.anchorToEdge(Edge.Bottom, padding: 0, width: YMSizes.PageWidth, height: YMSizes.OnPx)
        
        cell.addSubview(cellInner)
    }
    
    public func DrawHospitals(data: NSDictionary?) {
        let realData = data!["data"]! as! Array<AnyObject>
        DrawSearchResult(realData)
    }

    public func ClearList() {
        SearchResultTable?.Clear()
    }
    
    private func DrawSearchResult(data: Array<AnyObject>) {
        Loading?.Hide()
        SearchResultTable?.Clear()
        
        var i = 0
        for v in data {
            SearchResultTable?.AppendCell(v)
            i += 1
        }
        
        SearchResultTable?.TableViewPanel.removeFromSuperview()
        BodyView.addSubview((SearchResultTable?.TableViewPanel)!)
        SearchResultTable?.TableViewPanel.alignAndFill(align: Align.UnderMatchingLeft, relativeTo: InputPanel, padding: 0)
        
        SearchResultTable?.DrawTableView(false)
    }

    public func ShowInitHospitals() {
        Loading?.Show()
        SearchActions?.InitHospitalList()
    }
}













































