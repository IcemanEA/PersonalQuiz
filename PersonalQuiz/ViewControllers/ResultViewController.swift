//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 07.07.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
               
        if let animal = getResultAnimal() {
            resultLabel.text = "Вы - \(animal.rawValue)!"
            descriptionLabel.text = animal.definition
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    private func getResultAnimal() -> Animal? {
        var resultScores = [Animal: Int]()
        
        for answer in answers {
            if let oldResult = resultScores.updateValue(1, forKey: answer.animal) {
                resultScores.updateValue(oldResult + 1, forKey: answer.animal)
            }
        }
               
        let maxScore = resultScores.max { $0.value < $1.value }
        guard let animal = maxScore?.key else { return nil }
        
        return animal
    }
}
