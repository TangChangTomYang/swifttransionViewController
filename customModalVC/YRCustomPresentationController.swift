//
//  YRCustomPresentationController.swift
//  customModalVC
//
//  Created by yangrui on 2018/4/22.
//  Copyright © 2018年 yangrui. All rights reserved.
//

import UIKit

class YRCustomPresentationController: UIPresentationController {

    
    override func containerViewDidLayoutSubviews() {
        // 这个语法是这样的,如果前面 containerView?.bounds 获取到的是nil ,就取后面的值 CGRect()
        let frame = containerView?.bounds  ?? CGRect()
        let converBtn = UIButton(frame: frame)
        
        converBtn.addTarget(self, action: #selector(converBtnClick), for:.touchUpInside )
       
        converBtn.backgroundColor = UIColor.green
        containerView?.insertSubview(converBtn, at: 0)
    }
    
    //
    override func containerViewWillLayoutSubviews() {
        
//        containerView?.backgroundColor = UIColor.red;
        
        // 设置弹出来的View的尺寸
        presentedView?.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
       
    }
    
    
   @objc func converBtnClick() {
        presentedViewController .dismiss(animated: true, completion: nil)
    }
    
    
}
