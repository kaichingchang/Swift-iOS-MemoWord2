//
//  檔名： TestController.swift
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
import GameplayKit

class TestController: UIViewController {
    //MARK: 屬性
    
    //遊戲資料
    var wordData = [["蘋果", "apple"],
                    ["長凳", "bench"],
                    ["貓", "cat"],
                    ["桌子", "desk"],
                    ["大象", "elephant"],
                    ["花", "flower"],
                    ["手", "hand"],
                    ["冰淇淋", "ice cream"],
                    ["夾克", "jacket"],
                    ["小孩", "kid"]]

    //原始順序
    var array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    //題目與隨機排列的選項
    var answer = [Int:[Int]]()
    //題目順序
    var answerOrder = [Int]()
    
    //記錄遊戲次數
    var times = 0
    //記錄玩家按下哪個按鈕
    var useranswer: Int?
    //累計分數
    var score = 0
    
    //Core data
    static var count = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: 視窗屬性
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var dispaly: UILabel!
    
    //MARK: 視窗方法
    
    @IBAction func method1(_ sender: UIButton) {
        useranswer = 0
        next()
    }
    
    @IBAction func method2(_ sender: UIButton) {
        useranswer = 1
        next()
    }
    
    @IBAction func method3(_ sender: UIButton) {
        useranswer = 2
        next()
    }
    
    @IBAction func method4(_ sender: UIButton) {
        useranswer = 3
        next()
    }
    
    //MARK: 方法
    
    //處理按下按鈕後的情況
    func next() {
        //檢查玩家是否有答對做分數加減
        if let userinput = useranswer {
            if answerOrder[times] == answer[answerOrder[times]]![userinput] {
                score += 1
            }
            
            dispaly.text = String(score)
        }
        times += 1
        
        //遊戲結束處理
        if times == 10 {
            times = 0
            
            //遊戲次數遞增
            TestController.count += 1
            
            //儲存成績到 Core Data
            let task = Score(context: context)
            task.correct = Int64(score)
            task.times = Int64(TestController.count)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //轉移到 Result Scene
            let newScene = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "Result") as UIViewController
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.window?.rootViewController = newScene
        }
        else {
            //繼續顯示題目
            showQuestions()
        }
    }
    
    func showQuestions() {
        //設定題目
        question.text = wordData[answerOrder[times]][1]
        //設定選項
        let one = answer[answerOrder[times]]![0]
        let two = answer[answerOrder[times]]![1]
        let three = answer[answerOrder[times]]![2]
        let four = answer[answerOrder[times]]![3]
        button1.setTitle(wordData[one][0], for: .normal)
        button2.setTitle(wordData[two][0], for: .normal)
        button3.setTitle(wordData[three][0], for: .normal)
        button4.setTitle(wordData[four][0], for: .normal)
    }
    
    //隨機排列問題、答案的組合
    func setAnswerArray() {
        //設定答案與選項
        for item in array {
            answer[item] = [item]
            var count = 0
            var r = -1
            while true {
                r = Int(arc4random() % 10)
                if answer[item]!.contains(r) {
                    continue
                }
                if count == 3 {
                    break
                }
                answer[item]?.append(r)
                count += 1
            }
        }
        
        //攪亂選項順序
        for (item1, item2) in answer {
            answer[item1] = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: item2) as? [Int]
        }
        
        //攪亂題目順序
        answerOrder = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array) as! [Int]
    }
    
    //MARK: 預設方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //遊戲整體設定
        setAnswerArray()
        showQuestions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

