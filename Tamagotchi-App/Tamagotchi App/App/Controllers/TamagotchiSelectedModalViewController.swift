//
//  TamagotchiSelectedModalViewController.swift
//  Tamagotchi App
//
//  Created by walkerhilla on 2023/08/04.
//

import UIKit

final class TamagotchiSelectedModalViewController: UIViewController {
  
  // MARK: - Properties
  
  static let identifier = "TamagotchiSelectedModalViewController"
  
  @IBOutlet weak var modalBackView: UIView!
  @IBOutlet weak var tamagotchiImageView: UIImageView!
  @IBOutlet weak var tamagotchiNameView: UIView!
  @IBOutlet weak var tamagotchiNameLabel: UILabel!
  @IBOutlet weak var tamagotchiMessageLabel: UILabel!
  @IBOutlet var dividers: [UIView]!
  @IBOutlet weak var buttonView: UIView!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var startButton: UIButton!
  
  var tamagotchi: Tamagotchi?
  
  // MARK: - Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  
  // MARK: - UI Setup
  
  func configureUI() {
    
    setupDivider()
    setupModalBackView()
    setupTamagotchiImageView()
    setupTamagotchiNameView()
    setupTamagotchiNameLabel()
    setupTamagotchiMessageLabel()
    setupButttons()
  }
  
  func setupModalBackView() {
    
    //modalInnerView.backgroundColor = .clear
    modalBackView.backgroundColor = ColorConstant.backgroundColor
    modalBackView.layer.cornerRadius = 8
    modalBackView.clipsToBounds = true
  }
  
  func setupDivider() {
    
    dividers.forEach{ divider in
      divider.backgroundColor = ColorConstant.dividerColor
    }
  }
  
  func setupTamagotchiImageView() {
    
    guard let tamagotchi else { return }
    tamagotchiImageView.image = UIImage(named: tamagotchi.defaultImagePathToString)
  }
  
  func setupTamagotchiNameView() {
    
    tamagotchiNameView.backgroundColor = ColorConstant.labelBackgroundColor
    tamagotchiNameView.layer.borderColor = ColorConstant.textColor.cgColor
    tamagotchiNameView.layer.borderWidth = 0.7
    tamagotchiNameView.layer.cornerRadius = 5
    tamagotchiNameView.clipsToBounds = true
  }
  
  func setupTamagotchiNameLabel() {
    
    guard let tamagotchi else { return }
    tamagotchiNameLabel.text = tamagotchi.name
    tamagotchiNameLabel.font = .boldSystemFont(ofSize: 13)
    tamagotchiNameLabel.textColor = ColorConstant.textColor
  }
  
  func setupTamagotchiMessageLabel() {
    
    guard let tamagotchi else { return }
    tamagotchiMessageLabel.text = tamagotchi.introduceMessage
    tamagotchiMessageLabel.font = .systemFont(ofSize: 13)
    tamagotchiMessageLabel.textColor = ColorConstant.textColor
    tamagotchiMessageLabel.textAlignment = .center
    tamagotchiMessageLabel.numberOfLines = 0
  }
  
  func setupButttons() {
    
    buttonView.backgroundColor = .clear
    
    startButton.setTitle("시작하기", for: .normal)
    startButton.setTitleColor(ColorConstant.textColor, for: .normal)
    startButton.titleLabel?.font = .systemFont(ofSize: 14)
    startButton.setBackgroundColor(ColorConstant.buttonSelectedColor, for: .highlighted)
    
    cancelButton.setTitle("취소", for: .normal)
    cancelButton.setTitleColor(ColorConstant.textColor, for: .normal)
    cancelButton.titleLabel?.font = .systemFont(ofSize: 14)
    cancelButton.setBackgroundColor(ColorConstant.buttonSelectedColor, for: .normal)
    cancelButton.setBackgroundColor(ColorConstant.dividerColor, for: .highlighted)
  }
  
  func setNotify() {
    let content = UNMutableNotificationContent()
    content.title = "다마고치를 잊으신건 아니죠?"
    content.body = "밥과 물을 챙겨주세요"
    content.badge = 1
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
    let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
      print(error)
    }
  }  
  
  // MARK: - IBActions
  
  @IBAction func cancelButtonTapped(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  @IBAction func startButtonTapped(_ sender: UIButton) {
    if !UserDefaults.standard.bool(forKey: "isLaunched") {
      setNotify()
    }
    
    
    UserDefaults.standard.setValue(true, forKey: "isLaunched")
    
    guard let tamagotchi else { return }
    TamagotchiManager.shared.saveData(tamagotchi: tamagotchi)
    
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let sceneDelegate = windowScene?.delegate as? SceneDelegate
    
    let vc = storyboard?.instantiateViewController(identifier: TamagotchiMainViewController.identifier) as! TamagotchiMainViewController
    vc.tamagotchi = self.tamagotchi
    let nav = UINavigationController(rootViewController: vc)
    
    sceneDelegate?.window?.rootViewController = nav
    sceneDelegate?.window?.makeKeyAndVisible()
  }
}
