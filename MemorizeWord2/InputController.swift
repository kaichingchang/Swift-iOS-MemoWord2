//
//  檔名： InputController.swift
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

class InputController: UIViewController {
    //MARK: 屬性
    
    //Core data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [Word] = []
    
    //MARK: 視窗屬性
    @IBOutlet weak var chineseWord: UITextField!
    @IBOutlet weak var englishWord: UITextField!
    
    //MARK: 視窗方法
    
    @IBAction func addToDatabase(_ sender: UIButton) {
        if chineseWord.text != "" {
            if englishWord.text != "" {
                let task = Word(context: context)
                task.chinese = chineseWord.text
                task.english = chineseWord.text
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                englishWord.backgroundColor = UIColor.white
                chineseWord.backgroundColor = UIColor.white
            }
            else {
                englishWord.backgroundColor = UIColor.yellow
            }
        }
        else {
            chineseWord.backgroundColor = UIColor.yellow
        }
    }
    
    @IBAction func deleteDatabase(_ sender: UIButton) {
        //清除 Core Data 中的所有資料
        do {
            tasks = try context.fetch(Word.fetchRequest())
            for item in tasks {
                context.delete(item)
            }
        }
        catch {
            print("Fetching Failed")
        }
    }
        
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

