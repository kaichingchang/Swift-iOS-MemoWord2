//
//  檔名： ResultController.swift
//  專案： MemorizeWord2
//
//  《Swift 入門指南》 V3.00 的範例程式
//  購書連結
//         Google Play  : https://play.google.com/store/books/details?id=AO9IBwAAQBAJ
//         iBooks Store : https://itunes.apple.com/us/book/id1079291979
//         Readmoo      : https://readmoo.com/book/210034848000101
//         Pubu         : http://www.pubu.com.tw/ebook/65565?apKey=576b20f092
//
//  作者網站： http://www.kaiching.org
//  電子郵件： kaichingc@gmail.com
//
//  作者： 張凱慶
//  時間： 2017/08/03
//

import UIKit

class ResultController: UIViewController {
    //MARK: 屬性
    
    //Core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var taskScore: [Score] = []
    
    //MARK: 視窗屬性
    @IBOutlet weak var reault: UITextView!
    
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //載入成績
        do {
            taskScore = try context.fetch(Score.fetchRequest())
            
            //顯示成績
            reault.text? += "\n"
            for item in taskScore {
                let a = item.times
                let b = item.correct
                reault.text? +=  String(a) + " - " + String(b) + "\n"
            }
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

