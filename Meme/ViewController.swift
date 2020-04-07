//
//  ViewController.swift
//  ImagePickerExperiment
//
//  Created by LALIT JAGTAP on 4/5/20.
//  Copyright © 2020 LALIT JAGTAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let titleTop = "TOP"
    let titleBottom = "BOTTOM"
    let defaultFontName = "HelveticaNeue-CondensedBlack"
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTextField(topTextField, with: titleTop)
        configureTextField(bottomTextField, with: titleBottom)

        disableShareButton()
    }
    
    func configureTextField(_ textField: UITextField, with title: String) {
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.backgroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: defaultFontName, size: 40)!,
            NSAttributedString.Key.strokeWidth:  5.0
        ]

        textField.defaultTextAttributes = memeTextAttributes
        
        textField.textAlignment = .center
        textField.text = title
        textField.delegate = self
    }
    
    private func disableShareButton() {
        shareBarButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribetoKeyboardNotifications()
        cameraBarButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func pickFromSource(_ source: UIImagePickerController.SourceType) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.sourceType = source
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: UIBarButtonItem) {
        pickFromSource(.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        pickFromSource(.camera)
    }
    
    func save() {
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()

        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: [])
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.completionWithItemsHandler = {(activityType, completed, returnedItems, error) in
    
            if completed {
                self.save()
            }
        }
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerView.image = nil
        topTextField.text = titleTop
        bottomTextField.text = titleBottom
        
        disableShareButton()
    }
    
    
    // MARK: Generate memed image, by hdiing toolbars
    
    func generateMemedImage() -> UIImage {

        topToolBar.isHidden = true
        bottomToolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolBar.isHidden = false
        bottomToolBar.isHidden = false
    
        return memedImage
    }

    
    // MARK: Image Picker delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            imagePickerView.image = image
            shareBarButton.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        disableShareButton()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Text field delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        return true;
    }
    
    // set the current text field, to help validate if it is being covered by Keyboard
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    // MARK: Keyboard notification and its movement by shifting the view
    func subscribetoKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        // if active text field is hidden by keyboard
        var aRect: CGRect = self.view.frame
        aRect.size.height -= getKeyboardHeight(notification)
        if (!aRect.contains(activeTextField.frame.origin) ) {
            // yes, so scroll current view so text field is visible
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
}

