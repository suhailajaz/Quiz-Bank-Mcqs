//
//  ViewController.swift
//  Project2- Quiz Bank
//
//  Created by suhail on 07/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblScore: UILabel!
    @IBOutlet var lblQuestion: UILabel!
    @IBOutlet var btnFirstAnswer: UIButton!
    @IBOutlet var btnSecondAnswer: UIButton!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var lblWrong: UILabel!
    @IBOutlet var btnThirdAnswer: UIButton!
    
    var timer = Timer()
    var quizManager = QuizManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let questionSet = QuestionSet().questions
        quizManager.questions = questionSet.shuffled()
    
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.cyan.cgColor,UIColor.darkGray.cgColor,UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        giveBordersAndCOrners()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: UIButton) {
        
        guard let currentAnswer = sender.titleLabel?.text else { return }
        
        let whatUserGot = quizManager.checkAnswer(selectedAnswer: currentAnswer)
        if whatUserGot{
            sender.backgroundColor = UIColor.green
        }else{
            sender.backgroundColor = UIColor.red
        }
        
        quizManager.nextQuestion()
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(checkUI), userInfo: nil, repeats:false)
        
    }
}

extension ViewController{
    func giveBordersAndCOrners(){
        
        btnFirstAnswer.layer.borderColor = UIColor.white.cgColor
        btnFirstAnswer.layer.borderWidth = 1
        btnFirstAnswer.layer.cornerRadius = 20
        
        btnSecondAnswer.layer.borderColor = UIColor.white.cgColor
        btnSecondAnswer.layer.borderWidth = 1
        btnSecondAnswer.layer.cornerRadius = 20
        
        btnThirdAnswer.layer.borderColor = UIColor.white.cgColor
        btnThirdAnswer.layer.borderWidth = 1
        btnThirdAnswer.layer.cornerRadius = 20
       

      
      
    }
    
    @objc func checkUI(){
    
        if !quizManager.gameOver{
           updateUI()
        }else{
            let ac = UIAlertController(title: "Game Over", message: "Please press oK if you want to start again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default,handler: { [weak self] _ in
                self?.quizManager.gameOver = false
                self?.quizManager.questions.shuffle()
                self?.updateUI()
            }))
            present(ac,animated: true)
        }
   
    }
    
    func updateUI(){
        progressBar.progress = quizManager.getCurrentProgress()
        lblQuestion.text = quizManager.fetchQuestion()
        btnFirstAnswer.setTitle(quizManager.questions[quizManager.questionNumber].answer[0], for: .normal)
        btnSecondAnswer.setTitle(quizManager.questions[quizManager.questionNumber].answer[1], for: .normal)
        btnThirdAnswer.setTitle(quizManager.questions[quizManager.questionNumber].answer[2], for: .normal)
        btnFirstAnswer.backgroundColor = .clear
        btnSecondAnswer.backgroundColor = .clear
        btnThirdAnswer.backgroundColor = .clear
        lblScore.text = "Score: \(quizManager.score)"
        lblWrong.text = "Wrong: \(quizManager.wrong)"
        
    }
}

