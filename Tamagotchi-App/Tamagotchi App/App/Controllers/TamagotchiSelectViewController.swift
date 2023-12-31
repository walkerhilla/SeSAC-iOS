//
//  TamagotchiSelectViewController.swift
//  Tamagotchi App
//
//  Created by walkerhilla on 2023/08/04.
//

import UIKit

/// 다마고치 선택하기 화면 뷰 컨트롤러
final class TamagotchiSelectViewController: UIViewController {
  
  //MARK: - View Property
  
  static let identifier = "TamagotchiSelectViewController"
  
  @IBOutlet weak var tamagotchiSelectCollectionView: UICollectionView!
  
  //MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureView()
    setupCollectionView()
  }
  
  //MARK: - setup UI
  
  /// configure View Controller property
  private func configureView() {
    
    view.backgroundColor = ColorConstant.backgroundColor

    let titleLabel = UILabel()
    titleLabel.text = StringConstant.tamagotchiSelectTitle
    titleLabel.textColor = ColorConstant.textColor
    titleLabel.font = .monospacedDigitSystemFont(ofSize: 15, weight: .heavy)
    navigationItem.titleView = titleLabel
  }
  
  /// set up collectionView
  private func setupCollectionView() {
    
    tamagotchiSelectCollectionView.backgroundColor = ColorConstant.backgroundColor
    tamagotchiSelectCollectionView.dataSource = self
    tamagotchiSelectCollectionView.delegate = self
    
    registerTamagotchiSelectCell()
    setupCollectionViewLayout()
  }
  
  /// Cell Register Method
  private func registerTamagotchiSelectCell() {
    
    let nib = UINib(nibName: TamagotchiSelectCollectionViewCell.identifier, bundle: nil)
    tamagotchiSelectCollectionView.register(nib, forCellWithReuseIdentifier: TamagotchiSelectCollectionViewCell.identifier)
  }
  
  /// set up collectionView layout
  private func setupCollectionViewLayout() {
    
    let layout = UICollectionViewFlowLayout()
    let spacing: CGFloat = 20
    let width = UIScreen.main.bounds.width - (spacing * 4)
    layout.itemSize = CGSize(width: width/3, height: width/3)
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    
    tamagotchiSelectCollectionView.collectionViewLayout = layout
  }
}


// extension for CollectionView Delegate, Datasource
extension TamagotchiSelectViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  // section count
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return 1
  }
  
  // item count
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return 21
  }
  
  // configure Cell
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiSelectCollectionViewCell.identifier, for: indexPath) as? TamagotchiSelectCollectionViewCell else { return UICollectionViewCell() }
    
    let tamagotchis = TamagotchiInfo.shared.tamagotchis
    cell.tamagotchi = tamagotchis.count <= indexPath.row ? nil : tamagotchis[indexPath.row]
    cell.configureCell()
    
    return cell
  }
  
  // cell seleted
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard TamagotchiInfo.shared.tamagotchis.count > indexPath.row else { return }
    let vc = storyboard?.instantiateViewController(withIdentifier: TamagotchiSelectedModalViewController.identifier) as! TamagotchiSelectedModalViewController
    vc.tamagotchi = TamagotchiInfo.shared.tamagotchis[indexPath.row]
    vc.modalPresentationStyle = .overFullScreen
    present(vc,animated: true)
  }
}
