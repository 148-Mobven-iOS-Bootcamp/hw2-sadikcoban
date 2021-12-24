//
//  ViewController.swift
//  CommunicationPatterns
//
//  Created by can on 25.12.2021.
//

import UIKit
import UIKit



class BaseScreen: UIViewController {
    
    //definition of outlet view elements on the main page
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    

    //remove observers to de-allocate memory
    //when they are not required
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseButton.layer.cornerRadius = chooseButton.frame.size.height/2
        createObserver() //create background image observer
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //function to create observer listening to the selection so as to update background occasionally
    func createObserver() {
        //Light
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateBackground(notification:)), name: Constants.light, object: nil)
        
        //Dark
        NotificationCenter.default.addObserver(self, selector: #selector(BaseScreen.updateBackground(notification:)), name: Constants.dark, object: nil)
    }
    
   

    
    //background updater which runs when called by observer
    @objc func updateBackground(notification: NSNotification) {
        
        let isLight = notification.name == Constants.light
        let color = isLight ? UIColor.cyan : UIColor.red
        view.backgroundColor = color
    }
    
    
    //action function of choose buttton
    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        //create instante of selection screen
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionScreen") as! SelectionScreen
        //register delegate as self
        selectionVC.imageSelectionDelegate = self
        //update label with closure method
        selectionVC.setLabel = {(res) -> () in
            self.nameLabel.text = res
        }
        present(selectionVC, animated: true, completion: nil)
    }
 
    
}
//extension to confirm ImageSelectionDelegate Protocol
//which is responsible to update image shown on the screen
extension BaseScreen: ImageSelectionDelegate {
    func didTapChoice(image: UIImage) {
        mainImageView.image = image
    }
}
