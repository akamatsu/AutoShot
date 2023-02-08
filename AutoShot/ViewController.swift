//
//  ViewController.swift
//  AutoShot
//
//  Created by Masayuki Akamatsu on 2023/02/08.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.showsCameraControls = false
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: false)
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (timer:Timer) in
                self.picker.takePicture()
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        }
        self.dismiss(animated: false)
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
    }
}
