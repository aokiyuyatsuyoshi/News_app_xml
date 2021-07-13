//
//  ViewController.swift
//  News_app
//
//  Created by Yuya Aoki on 2021/07/10.
//

import UIKit
import Lottie

class ViewController: UIViewController,UIScrollViewDelegate{
    

    //スクロールビューのIBアウトレット
    @IBOutlet weak var ScrollView: UIScrollView!
    //jsonファイルを管理する配列
    var OnboardArray = ["1","2","11","12","13","6","7","8","9","10"]
    //オンボーディングに表示する文字
    var OnboardText = ["世の中の移り変わりというものは実に早いものです","昨日までの当たり前が今日では当たり前でなくなることも","完全に予想し的中させることは不可能でしょう","しかし、ニュースがあれば世の中の流れを理解し\n予想することができます","さあ、今日も世の中で起きたことを見ていきましょう！"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ページングを可能にする
        ScrollView.isPagingEnabled = true
        //縦のスクロールを無効化にする
        ScrollView.contentInsetAdjustmentBehavior = .never

        SetupScroll()
        
        for i in 0...9{
            //animationviewのインスタンス
            let animationView = AnimationView()
            //名前を指定する
            let animation = Animation.named(OnboardArray[i])
            //x:１ページの広さ(0.5だとサイズアニメーションのサイズ半分ごとに配置される)
            //y:0で画面ど真ん中へ。-で上部、+で下部へ
            //width:アニメーション自体のサイズ(0.5だと半分のサイズになる)
            //height:onboard全体の高さ
            animationView.frame = CGRect(x:CGFloat(i)*view.frame.size.width,y:0,width:view.frame.size.width, height:view.frame.size.height)
            //アニメーションを適用
            animationView.animation = animation
            //サイズを調整
            animationView.contentMode = .scaleAspectFit
            //あってもなくても変わらない？調査中
            animationView.loopMode = .loop
            //アニメーションを実行
            animationView.play()
            //scrollviewにアニメーションを追加する
            ScrollView.addSubview(animationView)
            
        }
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションバーを消す
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func SetupScroll(){
        
        ScrollView.delegate = self
        //スクロールビューのサイズを指定
        //x:view.frame.size,width*5で５ページ遷移する
        //y:scrollviewの高さ
        ScrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: ScrollView.frame.size.height)
        
        for i in 0...4{
            //x:0.5にすると文字が被ってしまう、1で丁度１ページに一文
            //y:数値が大きいほど下にいく
            //width:アニメーション自体のサイズ(0.5だと半分のサイズになる)
            //height:onboard全体の高さ
            let onboardLabel = UILabel(frame: CGRect(x:CGFloat(i)*view.frame.size.width,y:view.frame.size.height/3,width: ScrollView.frame.size.width,height: ScrollView.frame.size.height))
            
            //boldに指定
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.numberOfLines = 0
            //真ん中よりに指定
            onboardLabel.textAlignment = .center
            onboardLabel.text = OnboardText[i]
            ScrollView.addSubview(onboardLabel)
        
        }
    }


}

