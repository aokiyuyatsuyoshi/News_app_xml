//
//  WebViewController.swift
//  News_app
//
//  Created by Yuya Aoki on 2021/07/12.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate{
    
    //webViewを生成
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //コードで生成
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-50)
        //実際にwebViewを画面に配置する
        view.addSubview(webView)
        //リクエストを送信するURLを設定(any型からstring型へ)
        let url = URL(string:UserDefaults.standard.object(forKey: "url") as! String)
        //リクエストを送信
        let Request = URLRequest(url: url!)
        //webviewにリクエストを送る
        webView.load(Request)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
