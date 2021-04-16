//
//  SignupViewController.swift
//  Forms_task
//
//  Created by Littlebuddha on 15/04/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var FirstnameTextField: UITextField!
    @IBOutlet weak var LastnameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RepasswordTextField: UITextField!
    @IBOutlet weak var SignupButton: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ErrorLabel.alpha = 0
    }
    
    func validateField() -> String?
    {
        //check all fields are filled
        
        if FirstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || LastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || RepasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            return "All Fields need to be filled"
        }
        
        
        
        return nil
    }
    
    @IBAction func SignupTap(_ sender: Any) {
        
        let error = validateField()
        
        if error != nil{
            showError(error!)
        }
        else{
            //create cleaned version of data
            let firstname = FirstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = LastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user
            Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                //check for errors
                if err != nil {
                    //there is an error
                    self.showError("Error creating user")
                }
                else
                {
                    //user created
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["First_name":firstname,"Last_name":lastname,"uid":result!.user.uid ]) { (error) in
                        if error != nil{
                            //showing error
                            self.showError("User Data Couldn't be stored")
                        }
                    }
                    
                    //transition to home screen
                    self.transitiontohome()
                }
            }
            
            
        }
        
    }
    
    func showError(_ message:String)
    {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    func transitiontohome()
    {
        
        let homeviewcontroller = storyboard?.instantiateViewController(identifier: constants.storyboard.homeviewcontroller) as? HomeViewController
        
        view.window?.rootViewController = homeviewcontroller
        view.window?.makeKeyAndVisible()
    }
}
