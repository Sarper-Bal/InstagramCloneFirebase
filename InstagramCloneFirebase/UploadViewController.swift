//
//  UploadViewController.swift
//  InstagramCloneFirebase
//
//  Created by Sarper Bal on 12.04.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)

     
    }
    
    @objc func chooseImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        let alert =  UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    @IBAction func actionButtonCliced(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        let uuid = UUID().uuidString
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
             
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Errroe")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost =  ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0 ] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error" )
                                } else {
                                    
                                    self.imageView .image = UIImage(named: "select.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                           
                            
                        }
                    }
                }
            }
        }
    }
    
   
}
