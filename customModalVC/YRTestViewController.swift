//
//  YRTestViewController.swift
//  customModalVC
//
//  Created by yangrui on 2018/4/22.
//  Copyright © 2018年 yangrui. All rights reserved.
//

import UIKit

class YRTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = UIColor.purple
    }
    

    // 这个方法只有在View 的范围内点击才能执行
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
