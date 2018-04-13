//
//  QuestionViewController.swift
//  WordList
//
//  Created by 大林拓実 on 2018/04/12.
//  Copyright © 2018年 Life is tech. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var isAnswered: Bool = false    //回答したか，次の問題に行くかの判定
    var wordArray: [Dictionary<String, String>] = []    //Userdefaultsからとる配列
    var shuffledWordArray: [Dictionary<String, String>] = []    //シャッフルされた配列
    var nowNumber: Int = 0  //現在の回答数
    
    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
    }
    
    //viewが呼ばれた時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wordArray = saveData.array(forKey: "WORD") as! [Dictionary<String, String>]
        //問題をシャッフルする
        shuffle()
        questionLabel.text = shuffledWordArray[nowNumber]["english"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shuffle(){
        while wordArray.count > 0 {
            let index = Int(arc4random()) % wordArray.count
            shuffledWordArray.append(wordArray[index])
            wordArray.remove(at: index)
        }
    }

    @IBAction func nextButtonTapped(){
        //回答したか
        if isAnswered {
            //次の問題へ
            nowNumber += 1
            answerLabel.text = ""
            
            //次の問題を表示するか
            if nowNumber < shuffledWordArray.count {
                //次の問題を表示
                questionLabel.text = shuffledWordArray[nowNumber]["english"]
                //isAnsweredをfalseに
                isAnswered = false
                //ボタンタイトルを変更
                nextButton.setTitle("答えを表示", for: .normal)
            } else {
                //これ以上問題がないので，FinishViewに移動
                self.performSegue(withIdentifier: "toFinishView", sender: nil)
            }
        } else {
            //答えを表示する
            answerLabel.text = shuffledWordArray[nowNumber]["japanese"]
            //isAnsweredをtrueに
            isAnswered = true
            //ボタンタイトルを変更
            nextButton.setTitle("次へ", for: .normal)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
