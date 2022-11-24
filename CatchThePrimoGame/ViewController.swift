//
//  ViewController.swift
//  CatchThePrimoGame
//
//  Created by Mustafa Çalış on 24.11.2022.
//

import UIKit

class ViewController: UIViewController {
    //Veriables
    var score = 0
    var timer = Timer()
    var counter = 0
    var primoArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Wiews
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    
    @IBOutlet weak var primo1: UIImageView!
    @IBOutlet weak var primo2: UIImageView!
    @IBOutlet weak var primo3: UIImageView!
    @IBOutlet weak var primo4: UIImageView!
    @IBOutlet weak var primo5: UIImageView!
    @IBOutlet weak var primo6: UIImageView!
    @IBOutlet weak var primo7: UIImageView!
    @IBOutlet weak var primo8: UIImageView!
    @IBOutlet weak var primo9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score : \(score)"
        
        
        //Highscore check
               
               let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
               
               if storedHighScore == nil {
                   highScore = 0
                   highLabel.text = "Highscore: \(highScore)"
               }
               
               if let newScore = storedHighScore as? Int {
                   highScore = newScore
                   highLabel.text = "Highscore: \(highScore)"
               }
        
        
        
        // Image
        primo1.isUserInteractionEnabled = true
        primo2.isUserInteractionEnabled = true
        primo3.isUserInteractionEnabled = true
        primo4.isUserInteractionEnabled = true
        primo5.isUserInteractionEnabled = true
        primo6.isUserInteractionEnabled = true
        primo7.isUserInteractionEnabled = true
        primo8.isUserInteractionEnabled = true
        primo9.isUserInteractionEnabled = true
        
        
        
        let reconizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let reconizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        primo1.addGestureRecognizer(reconizer1)
        primo2.addGestureRecognizer(reconizer2)
        primo3.addGestureRecognizer(reconizer3)
        primo4.addGestureRecognizer(reconizer4)
        primo5.addGestureRecognizer(reconizer5)
        primo6.addGestureRecognizer(reconizer6)
        primo7.addGestureRecognizer(reconizer7)
        primo8.addGestureRecognizer(reconizer8)
        primo9.addGestureRecognizer(reconizer9)
        
        
        
        primoArray = [primo1,primo2,primo3,primo4,primo5,primo6,primo7,primo8,primo9]
        
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidePrimo), userInfo: nil, repeats: true)
        
     hidePrimo()
        
    }
    
    
    
     @objc func hidePrimo () {
        for primo in primoArray {
            primo.isHidden = true
        }
        
        
        let random = Int(arc4random_uniform(UInt32(primoArray.count - 1)))
        primoArray[random].isHidden = false
        
        
        
    }
    
    
    
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for primo in primoArray {
                primo.isHidden = true
            }

            //HighScore
            
            
            if self.score > self.highScore {
                self.highScore = self.score
                highLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                            //replay function
                            
            self.score = 0
            self.scoreLabel.text = "Score: \(self.score)"
            self.counter = 10
            self.timeLabel.text = String(self.counter)
                            
                            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidePrimo), userInfo: nil, repeats: true)
                        }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

