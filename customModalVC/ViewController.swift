//
//  ViewController.swift
//  customModalVC
//
//  Created by yangrui on 2018/4/22.
//  Copyright © 2018年 yangrui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isPresent : Bool = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let redVC = YRTestViewController()
        redVC.modalPresentationStyle = .custom
        redVC.transitioningDelegate = self
        isPresent = true
        present(redVC, animated: true, completion: nil)
    }

}


// MARK:- 自定义modal控制器的代理
extension ViewController : UIViewControllerTransitioningDelegate{
    
    
    //弹出 modal 控制器的 容器
    //如果要自定义 present 出来的控制器的大小需要 返回自定义的UIPresentationController
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController?{
       
        print("\(presented),\(String(describing: presenting)),\(source)")
        
        return YRCustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    //1. 自定义弹出动画,返回弹出的代理即可 (此处需要设置代理)
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return self
    }
//
    //1.自定义dismiss动画 (此处需要设置代理)
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return self
    }
    
}


extension  ViewController : UIViewControllerAnimatedTransitioning{
    // 动画的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        
        return 1.0
    }
    
    
    
    // 通过转场上下文可以获取 弹出的View 和消失的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        //1.弹出动画
        if isPresent == true {
            isPresent = false
            if let presentedView =  transitionContext.view(forKey: .to) { // modal 出来的
                
                //2. 将弹出的View添加到container 里面
                transitionContext.containerView.addSubview(presentedView)
                
                //3. 设置转场的动画
                presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0)
                presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
                
                
                UIView.animate(withDuration:transitionDuration(using: transitionContext) , animations: {
                    
                    presentedView.transform = CGAffineTransform.identity
                }) { (isFinish) in
                    // 动画完成后要通知转场动画完成
                    if isFinish == true {
                        transitionContext.completeTransition(true)
                    }
                    
                }
                
                return
            }
        }
        else{
            
            //1. dismiss 动画
            if let dismissView =  transitionContext.view(forKey: .from) { // dismiss 回去
                
                UIView.animate(withDuration:transitionDuration(using: transitionContext) , animations: {
                    //3. 设置转场的动画
                    // 注意,iOS 对临界值处理的不好, 因此不要写成 CGAffineTransform(scaleX: 1.0, y: 0) 否则没有动画
                    dismissView.transform = CGAffineTransform(scaleX: 1.0, y: 0.001)
                }) { (isFinish) in
                    // 动画完成后要通知转场动画完成
                    if isFinish == true{
                        //2. 将弹出的View从container 里面移除
                        dismissView.removeFromSuperview()
                        transitionContext.completeTransition(true)
                    }
                    
                }
            }
        }
       
        
       

        
    }
    
}












