//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by İbrahim Şahan on 4.05.2024.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.presentAlert(title: "Error", message: error?.localizedDescription ?? "An error occured while uploading the image.", actionTitle: "OK", actionHandler: nil)
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            let firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.commentText.text!, "postDate": Date(), "likes": 0] as [String : Any]
                            
                            
                            firestoreDatabase.collection("posts").addDocument(data: firestorePost) { (error) in
                                if error != nil {
                                    self.presentAlert(title: "Error", message: error?.localizedDescription ?? "An error occured while saving the data.", actionTitle: "OK", actionHandler: nil)
                                } else {
                                    self.imageView.image = UIImage(named: "upload.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
