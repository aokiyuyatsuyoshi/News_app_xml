//
//  BaseViewController.swift
//  News_app
//
//  Created by Yuya Aoki on 2021/07/10.
//

import UIKit
import SegementSlide
import Lottie


class ThirdViewController: SegementSlideDefaultViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        //タブの初期位置
        defaultSelectedIndex = 0
    }
    
    
    override func segementSlideHeaderView() -> UIView {
                //animationviewのインスタンス
        let animationView = AnimationView()
        //名前を指定する
        let animation = Animation.named("12")
        animationView.frame = CGRect(x:0,y:0,width:19, height:19)
        //アニメーションを適用
        animationView.animation = animation
        //あってもなくても変わらない？調査中
        animationView.loopMode = .loop
        //アニメーションを実行
        animationView.play()
    //あとで見てみる
        animationView.isUserInteractionEnabled = true
    //あとで見てみる
        animationView.translatesAutoresizingMaskIntoConstraints = false
    //ヘッダーの高さの変数
    let headerHeight: CGFloat
    //ちょっとここわからないので調べる
    if #available(iOS 11.0, *) {

    headerHeight = view.bounds.height/4+view.safeAreaInsets.top

    } else {

    headerHeight = view.bounds.height/4+topLayoutGuide.length

    }
//    //???
        animationView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

    return animationView

    }
    
    override var titlesInSwitcher: [String] {
          return ["TOP", "国内", "IT","エンタメ","国際","経済"]
      }
    
    //indexにどこのタブがよばれているか
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        
        switch index{
        
        case 0:
            UserDefaults.standard.set("TOP", forKey: "key")
            return Page1TableViewController()
        case 1:
            UserDefaults.standard.set("国内", forKey: "key")
            return Page1TableViewController()
        case 2:
            UserDefaults.standard.set("IT", forKey: "key")
            return Page1TableViewController()
        case 3:
            UserDefaults.standard.set("エンタメ", forKey: "key")
            return Page1TableViewController()
        case 4:
            UserDefaults.standard.set("国際", forKey: "key")
            return Page1TableViewController()
        case 5:
            UserDefaults.standard.set("経済", forKey: "key")
            return Page1TableViewController()
        
        
        default:
            return Page1TableViewController()
        }
        
    }

}
