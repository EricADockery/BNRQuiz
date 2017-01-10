//
//  ViewController.swift
//  Quiz
//
//  Created by Eric Dockery on 1/3/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextQuestionLabel: UILabel!
    @IBOutlet weak var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    var currentQuestionIndex = 0
    var questionModel: Questions?
    let noSolution = "????"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupQuestionModel()
        currentQuestionLabel.text = questionModel?.questions[currentQuestionIndex]
        updateOffScreenLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    func setupQuestionModel() {
        let questions = ["From what is cognac made?", "What is 7+7?", "What is the capital of Vermont?"]
        let answers = ["Grapes", "14", "Montpelier"]
        questionModel = Questions.init(questions: questions, answers: answers)
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 4,
            options: [.curveLinear],
            animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
        },
            completion: { _ in
            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            self.updateOffScreenLabel()
        })
    }

    @IBAction func showNextQuestion(_ sender: Any) {
        currentQuestionIndex += 1
        if let definedQuestionModel = questionModel {
            if currentQuestionIndex == definedQuestionModel.questions.count {
                currentQuestionIndex = 0
            }
            let question: String = definedQuestionModel.questions[currentQuestionIndex]
            nextQuestionLabel.text = question
            answerLabel.text = noSolution
            animateLabelTransitions()
        }
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        if let definedQuestionModel = questionModel {
            let answer = definedQuestionModel.answers[currentQuestionIndex]
            answerLabel.text = answer
        }
    }

}

