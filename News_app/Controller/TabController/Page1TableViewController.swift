//
//  Page1TableViewController.swift
//  News_app
//
//  Created by Yuya Aoki on 2021/07/11.
//

import UIKit
import SegementSlide

class Page1TableViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate{

    //xml解析に用いる
    var parser = XMLParser()
    //パース中の現在の要素
    var currentElementName:String!
    //ニュース一覧の配列
    var newsArray = [NewsModel]()
    //どのタブが選択されたのか
    let key = UserDefaults.standard.object(forKey: "key") as! String
    //URLを格納する
    var url:URL = URL(string: "https://news.yahoo.co.jp/rss/topics/top-picks.xml")!
    //イメージを指定
    var image = UIImage(named: "")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableViewの背景を透明に
        tableView.backgroundColor = .clear

        //サイズを指定
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height))

        //タブによりXMLのURLを変更する
        switch key {
        case "TOP":
            url = URL(string: "https://news.yahoo.co.jp/rss/topics/top-picks.xml")!
            image = UIImage(named: "america")!
        case "国内":
            url = URL(string: "https://news.yahoo.co.jp/rss/categories/domestic.xml")!
            image = UIImage(named: "japan")
        case "IT":
            url = URL(string: "https://news.yahoo.co.jp/rss/categories/it.xml")!
            image = UIImage(named: "tech")
        case "エンタメ":
            url = URL(string: "https://news.yahoo.co.jp/rss/topics/entertainment.xml")!
            image = UIImage(named: "live")
        case "国際":
            url = URL(string: "https://news.yahoo.co.jp/rss/categories/world.xml")!
            image = UIImage(named: "foreign")
        case "経済":
            url = URL(string: "https://news.yahoo.co.jp/rss/topics/business.xml")!
            image = UIImage(named: "eco")
        default:
            url = URL(string: "")!
        }
        //xmlparserに指定
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        print("key:" + String(key))
        print(parser)
        //実際にparse
        parser.parse()
        
        //イメージを設定
        imageView.image = image
        tableView.backgroundView = imageView

    }
    
    //
    @objc var scrollView: UIScrollView{
        return tableView
    }

    // MARK: - Table view data source

    //セクションは1
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //1セクション中のセルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsArray.count
    }

    //１セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/5
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        cell.backgroundColor = .clear
        //
        let newsitems = self.newsArray[indexPath.row]
        
        //セルにニュースのタイトルを設定
        cell.textLabel?.text = newsitems.title
        //フォントを指定
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        //テキストカラーを白にする
        cell.textLabel?.textColor = .white
        //改行は3
        cell.textLabel?.numberOfLines = 3
        //サブタイトル（二行目）
        cell.detailTextLabel?.text = newsitems.url
        cell.detailTextLabel?.textColor = .white
        

        return cell
    }
    
    //実際にXML解析を行う //didstartElementが引っ張り始める要素名
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        //itemという要素があれば
        if elementName == "item"{
            newsArray.append(NewsModel())
        }else{
            currentElementName = elementName
        }
    }
    
    //実際にXML解析を行う //foundCharactersが実際に持ってくる値
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsArray.count > 0 {
            let lastItem = self.newsArray[self.newsArray.count-1]
            
             //currentElementNameに入る値で条件分岐
            switch self.currentElementName{
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.publishDate = string
            default:break
            }
        }
    }
    
    //最後の要素なできたら空にする
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = ""
    }
    //パースした情報をtableview内に反映させる(reloadという意味が正しいかも)
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let webViewController = WebViewController()
        //モーダルで遷移するときのトランディション
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItems = newsArray[indexPath.row]
        //urlという名前で
        UserDefaults.standard.set(newsItems.url, forKey: "url")
        present(webViewController, animated: true, completion: nil)
        
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
