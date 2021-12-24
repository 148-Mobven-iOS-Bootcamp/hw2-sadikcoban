//
//  ViewController.swift
//  CommunicationPatterns
//
//  Created by can on 25.12.2021.
//


import UIKit

//protocol to update background image
protocol ImageSelectionDelegate {
    func didTapChoice(image: UIImage)
}

class SelectionScreen: UIViewController {
    
    var imageSelectionDelegate: ImageSelectionDelegate!
    
    //closure responsible to notify selected label
    public var setLabel: ((String) -> ())!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func imperialButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: Constants.darkNotification, object: nil)
        setLabel(Constants.darkLabel)
        imageSelectionDelegate.didTapChoice(image: UIImage(named: Constants.darkImage)!)
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func rebelButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: Constants.lightNotification, object: nil)
        setLabel(Constants.lightLabel)
        imageSelectionDelegate.didTapChoice(image: UIImage(named: Constants.lightImage)!)
      
        dismiss(animated: true, completion: nil)
    }
}
