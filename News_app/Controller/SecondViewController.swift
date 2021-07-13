//
//  SecondViewController.swift
//  News_app
//
//  Created by Yuya Aoki on 2021/07/10.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    //avPlayerのインスタンス作成
    var player = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        //ファイル名と拡張子を設定する
        let path = Bundle.main.path(forResource: "1", ofType: "mov")
        //URL型に変換したpathをAVplayerに代入
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //AVplayer用のレイヤーを作成
        let playerLayer = AVPlayerLayer(player: player)
        //サイズを指定
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        //こちらも画像のフィット
        playerLayer.videoGravity = .resizeAspectFill
        //0だと無限ループ
        playerLayer.repeatCount = 0
        //背面に置きたいので-1
        playerLayer.zPosition = -1
        //layerに追加
        view.layer.insertSublayer(playerLayer, at: 0)
        
        //動画が最後まで流れてループする処理のクロージャ
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main){(_) in
            //開始の時間を指定（最初から）
            self.player.seek(to: .zero)
        }
        
        //動画の再生
        self.player.play()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションバーを隠す
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //Let's startボタンが押された時に動画を止める
    @IBAction func StartButton(_ sender: Any) {
        self.player.pause()
    }
    


}
