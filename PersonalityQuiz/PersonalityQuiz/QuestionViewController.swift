//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Timo den Hartog on 16-11-17.
//  Copyright © 2017 Timo den Hartog. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var SingleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    @IBOutlet weak var MultipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var RangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedLabel3: UILabel!
    @IBOutlet weak var rangedLabel4: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questions: [Question] = [
        Question(text: "What party do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "ZeeZout", type: .house),
                    Answer(text: "Reaktor", type: .techno),
                    Answer(text: "TomorrowLand", type: .EDM),
                    Answer(text: "50hurtz", type: .dubstep),
                    ]),
        
        Question(text: "What characteristics attract you the most?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Groove", type: .house),
                    Answer(text: "Intensity", type: .techno),
                    Answer(text: "Catchyness", type: .EDM),
                    Answer(text: "Chaos", type: .dubstep),
                    ]),
        
        Question(text: "Do you care about the crowd you attract?",
                 type: .ranged,
                 answers: [
                    Answer(text: "yes, a bit", type: .house),
                    Answer(text: "A lot", type: .techno),
                    Answer(text: "No, just pay", type: .EDM),
                    Answer(text: "No, go crazy", type: .dubstep),
                    ]),
        
        ]
    
    var questionIndex = 0
    var answerChosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:answerChosen.append(currentAnswers[0])
        case singleButton2:answerChosen.append(currentAnswers[1])
        case singleButton3:answerChosen.append(currentAnswers[2])
        case singleButton4:answerChosen.append(currentAnswers[3])
        default: break
        }
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
    
        if multiSwitch1.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answerChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func UpdateUI () {
        SingleStackView.isHidden = true
        MultipleStackView.isHidden = true
        RangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        SingleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        MultipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        RangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        //rangedLabel2.text = answers[2].text
        //rangedLabel3.text = answers[3].text
        rangedLabel4.text = answers.last?.text
    }
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            UpdateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answerChosen
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
