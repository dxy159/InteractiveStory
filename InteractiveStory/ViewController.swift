//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Richard Ni on 2016-06-13.
//  Copyright © 2016 Richard Ni. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    enum Error: ErrorType {
        case NoName
    }

    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var textBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startAdventure" {
            
            do {
                if let name = nameTextField.text {
                    if name == "" {
                        throw Error.NoName
                    }
                    
                    if let pageController = segue.destinationViewController as? PageController {
                        pageController.page = Adventure.story("SupremeCockSucker")
                    }
                }
            } catch Error.NoName {
                let alertController = UIAlertController(title: "Name Not Provided", message: "Provide a name to start your story!", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                alertController.addAction(action)
                
                presentViewController(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error)")
            }
            
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfoDictionary = notification.userInfo, keyboardFrameValue = userInfoDictionary[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardFrame = keyboardFrameValue.CGRectValue()
            
            UIView.animateWithDuration(0.8) {
                self.textBottomConstraint.constant = keyboardFrame.size.height + 10
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillDisappear(notification: NSNotification) {
        UIView.animateWithDuration(0.8) {
            self.textBottomConstraint.constant = 40
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - UITextFieldDelegate
    // We use a delegate oattern to be notified of the text field's events because at most only a single object needs to know about the event
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
      
}















