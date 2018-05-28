//
//  NewEventController.swift
//  Events
//
//  Created by Rayan Aldafas on 23/05/2018.
//  Copyright © 2018 RayanAldafas. All rights reserved.
//

import UIKit
import CoreData

class NewEventController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var descriptionPlaceholderLabel: UILabel!
    
    @IBOutlet weak var uploadImageButton: UIButton!
    
    @IBOutlet weak var uploadedImage: UIImageView!
    
    let picker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // textView placeholder
        descriptionTextView.delegate = self

        // set up shadow and paading for textFields and textView and button
        setUpTextFieldShadowAndPadding( nameTextField.layer, false )
        setUpTextFieldShadowAndPadding( dateTextField.layer, false )
        setUpTextFieldShadowAndPadding( descriptionTextView.layer, true )
        setUpTextFieldShadowAndPadding( uploadImageButton.layer, false )
        uploadImageButton.layer.borderWidth = 0.8
        uploadImageButton.layer.borderColor = UIColor(red: 109/255.0, green: 160/255.0, blue: 226/255.0, alpha: 1.0).cgColor

        creatDatePicker()
    }
    
    func creatDatePicker() {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        toolbar.setItems([done], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = picker
        
        // format picker for date only
        picker.datePickerMode = .date
    }
    
    // date picker toolbar's done button pressed
    @objc func datePickerDonePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let stringDate = formatter.string(from: picker.date)
        
        // 
        dateTextField.text = "\(stringDate)"
        self.view.endEditing(true)
    }
    
    // shadow and padding for textField and textView by thier CALayer
    func setUpTextFieldShadowAndPadding (_ layer: CALayer,_ textView: Bool ) {
        // shadow
        layer.masksToBounds = false
        layer.shadowRadius = 1.5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.25
        layer.cornerRadius = 0.0
        
        // left padding
        if textView {
            layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        } else {
            layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)

        }
    }
    
    // change status bar style
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // description textView placeholder
    func textViewDidChange(_ textView: UITextView) {
        let newAlpha = textView.text.isEmpty ? 1.0 : 0.0
        if descriptionPlaceholderLabel.alpha != CGFloat(newAlpha) {
            UIView.animate(withDuration: 0) {
                self.descriptionPlaceholderLabel.alpha = CGFloat(newAlpha)
            }
        }
    }
    
    // to hide keyboard when user focus changes
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // save data entered
    @IBAction func saveButtonPressed(_ sender: Any) {

        // check if user uploaded image yet, if not dont save
        if uploadedImage.image != nil {
            
        let uploadedImagePNG:NSData = UIImagePNGRepresentation(uploadedImage.image!)! as NSData
        CoreDataHandler.saveEvent(name: nameTextField.text!, date: dateTextField.text!, eventDescription: descriptionTextView.text!, image:uploadedImagePNG ) ? print("save succeeded") : print("save failed")
        
        // refresh tableView data
        Singleton.shared.tableViewScreen.refreshTableView()
            
        // dismiss view after saving data
        self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    // when upload photo button pressed
    @IBAction func uploadPhotoPressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            
        }
    }
    
    // view the image after choosing it from library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            uploadedImage.image = image
        } else {
            print("uploading image failed")
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    
    // dismiss current view after pressing cancel button
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
