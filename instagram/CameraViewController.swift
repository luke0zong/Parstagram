//
//  CameraViewController.swift
//  instagram
//
//  Created by Yaowei on 10/16/21.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 400, height: 400)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        //
        //        let pet = PFObject(className: "Pets")
        //
        //        pet["name"] = "Draco"
        //        pet["bread"] = "Cat"
        //        pet["age"] = 5
        //        pet["owner"] = PFUser.current()!
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentText.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData() // binary data
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        
        post.saveInBackground { (success, error) in
            if success {
                print("Saved!")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
