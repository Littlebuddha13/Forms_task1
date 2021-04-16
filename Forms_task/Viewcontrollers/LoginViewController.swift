//
//  LoginViewController.swift
//  Forms_task
//
//  Created by Littlebuddha on 15/04/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ErrorLabel.alpha = 0
    }
    

    @IBAction func LoginButton(_ sender: Any) {
        
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if error != nil {
                //cannot sign in
                self.ErrorLabel.text = error!.localizedDescription
                self.ErrorLabel.alpha = 1
            }
            else
            {
                let homeviewcontroller = self.storyboard?.instantiateViewController(identifier: constants.storyboard.homeviewcontroller) as? HomeViewController
                
                self.view.window?.rootViewController = homeviewcontroller
                self.view.window?.makeKeyAndVisible()
                
            }
        }
    
        
        
        
    }
    

}
