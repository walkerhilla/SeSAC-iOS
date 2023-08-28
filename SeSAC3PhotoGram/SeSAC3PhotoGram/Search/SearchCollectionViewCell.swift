//
//  SearchCollectionViewCell.swift
//  SeSAC3PhotoGram
//
//  Created by walkerhilla on 2023/08/28.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
  
  let imageView = {
    let view = UIImageView()
    view.backgroundColor = .blue
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  override func configureView() {
    contentView.addSubview(imageView)
  }
  
  override func setConstraints() {
    imageView.snp.makeConstraints { make in
      make.edges.equalTo(self)
    }
  }
}
