//
//  ProfileEditViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var numberAdressTextField: UITextField!
    @IBOutlet weak var changeServicesButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var editPhotoButton:UIButton!
    @IBOutlet weak var serviceImageview: UIImageView!
    @IBOutlet weak var stateButton: UIButton!
    
    private var viewModelEditProfile:ViewModelEditProfile = ViewModelEditProfile()
    private var alert:AlertController?
    var imagePicker = UIImagePickerController()
    var valueStateButton:String?
    var storage: Storage?
    var firestore: Firestore?
    var auth: Auth?
    var users: [Dictionary<String, Any>] = []
    var posts: [Dictionary<String, Any>] = []
    var idUserLog: String?
    
    func getProfileData(){
        let user = self.firestore?.collection("users").document(self.idUserLog ?? "")
        user?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                let dataName = data?["name"]
                self.nameLabel.text = dataName as? String
                self.nameTextField.text = dataName as? String
                let dataNumber = data?["cellNumber"]
                self.numberTextField.text = dataNumber as? String
                let dataEmail = data?["email"]
                self.emailTextField.text = dataEmail as? String
                let dataCity = data?["city"]
                self.postalCodeTextField.text = dataCity as? String
                let dataBorn = data?["born"]
                self.dateTextField.text = dataBorn as? String
                let serverState = data?["server"]
                if serverState as? Int == 0{
                    self.changeServicesButton.isHidden = true
                    self.serviceImageview.isHidden = true
                }
//                if let url = data?["url"] as? String{
//                    self.profileImageView.sd_setImage(with: URL(string: url), completed: nil)
//                }else{
//                    self.profileImageView.image = UIImage(systemName: "person.circle.fill")
//                }
                }
                //                if let url = data?["url"] as? String{
                //                    self.profileImageView.sd_setImage(with: URL(string: url), completed: nil)
                //                }else{
                //                    self.profileImageView.image = UIImage(systemName: "person.circle.fill")
                //                }
            }
        }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFunc()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getProfileData()
    }
    
    func getFunc(){
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        Style()
        self.hideKeyboardWhenTappedAround()
        self.configTextField()
        self.configPhotoPicker()
        self.alert = AlertController(controller: self)
        self.enableSaveButton()
        if let idUser = auth?.currentUser?.uid{
            self.idUserLog = idUser
        }
    }
    
    func saveUserDefaults(value: Any, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    func getUserDefaults(key: String)-> Any?{
        return UserDefaults.standard.object(forKey: key)
    }
    
    func enableSaveButton(){
        self.saveButton.isEnabled = true
        self.saveButton.alpha = 1.0
    }
    func disableSaveButton(){
        self.saveButton.isEnabled = false
        self.saveButton.alpha = 0.0
    }
    
    func configTextField(){
        self.nameTextField.delegate = self
        self.numberTextField.delegate = self
        self.emailTextField.delegate = self
        self.dateTextField.delegate = self
        self.postalCodeTextField.delegate = self
        self.adressTextField.delegate = self
        self.numberAdressTextField.delegate = self
        self.viewModelEditProfile.textfieldStyle(textField: self.nameTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.numberTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.emailTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.dateTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.postalCodeTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.adressTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.numberAdressTextField, color: UIColor.ColorDefault)
        
        
        self.nameTextField.textColor = UIColor.darkGray
        self.emailTextField.textColor = UIColor.darkGray
        self.dateTextField.textColor = UIColor.darkGray
        self.nameTextField.isEnabled = false
        self.emailTextField.isEnabled = false
        self.dateTextField.isEnabled = false
    }
    
    func alert(title:String, message:String){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Aceitar", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configPhotoPicker(){
        self.imagePicker.delegate = self
    }
    
    func activeSaveButton(){
        if self.numberTextField.text != "" && self.dateTextField.text != "" && self.postalCodeTextField.text != "" && self.numberTextField.textColor != UIColor.red && self.postalCodeTextField.textColor != UIColor.red{
            self.enableSaveButton()
        }else{
            self.disableSaveButton()
        }
    }
    
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        if self.numberTextField.text == "" || self.numberTextField.textColor == UIColor.red || self.postalCodeTextField.text == "" || self.postalCodeTextField.textColor == UIColor.red || self.adressTextField.text == "" || self.adressTextField.textColor == UIColor.red || self.numberAdressTextField.text == "" || self.numberAdressTextField.textColor == UIColor.red {
            self.alert(title: "Atenção", message: "Verificar campos")
                self.activeSaveButton()
            
        }else{
            if let name = self.nameTextField.text, let email = self.emailTextField.text, let cellNumber = self.numberTextField.text, let born = self.dateTextField.text, let city = self.postalCodeTextField.text{
                self.firestore?.collection("users").document( self.idUserLog ?? "" )
                    .setData([
                        "name": name,
                        "email": email,
                        "cellNumber": cellNumber,
                        "born": born,
                        "city": city,
                        //                                        "profileImage": url,
                        "id": self.idUserLog as Any,
                    ])
                self.activeSaveButton()
            }else{
                print("Error")
                self.alert(title: "Erro", message: "Erro ao salvar")
            }
//            self.alert(title: "Atenção", message: "Alterações salvas.")
            self.alert?.showAlert(title: "Atenção", message: "Alterações Salvas", titleButton: "Aceitar", completion: { value in
                self.navigationController?.popToRootViewController(animated: true)
            })
            self.activeSaveButton()
        }
    }
    @IBAction func tappedChangePassword(_ sender: UIButton) {
        self.viewModelEditProfile.instantiateVC(nameVC: "ChangePasswordViewController", navigation: navigationController ?? UINavigationController())
    }
    
    @IBAction func tappedChangeService(_ sender: UIButton) {
        self.viewModelEditProfile.instantiateVC(nameVC: "myServices", navigation: navigationController ?? UINavigationController())
    }

    
    
    @IBAction func postalCodeAct(_ sender: UITextField) {
        let text = self.postalCodeTextField.text ?? ""
        if text.isValidPostalCode() {
            self.postalCodeTextField.textColor = UIColor.black
        } else {
            self.postalCodeTextField.textColor = UIColor.red
        }
    }
    
    @IBAction func phoneAct(_ sender: Any) {
        let text = self.numberTextField.text ?? ""
        if text.filterPhoneNumber().isValidPhone() {
            self.numberTextField.textColor = UIColor.black
        } else {
            self.numberTextField.textColor = UIColor.red
        }
    }
    
    @IBAction func tappedEditPhoto(_ sender: UIButton) {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileEditViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModelEditProfile.textfieldStyle(textField: textField, color: UIColor.blue)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            self.viewModelEditProfile.textfieldStyle(textField: textField, color: UIColor.red)
        }else{
            self.viewModelEditProfile.textfieldStyle(textField: textField, color: UIColor.ColorDefault)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activeSaveButton()
        return true
    }
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
}

extension ProfileEditViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImageView.contentMode = .scaleAspectFill
            self.profileImageView.image = pickedImage
            self.viewModelEditProfile.cornerRadius(image: profileImageView)
            self.profileImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
