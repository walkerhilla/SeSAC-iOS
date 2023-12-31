//
//  SampleViewModel.swift
//  SeSAC3UnsplashProject
//
//  Created by walkerhilla on 2023/09/12.
//

import Foundation

class SampleViewModel {
  
  var list: [User] = [
    User(name: "Hue", age: 23),
    User(name: "Jack ", age: 21),
    User(name: "Bran ", age: 20),
    User(name: "Kokojong ", age: 20)
  ]
  
  var numberOfRowInSection: Int {
    list.count
  }
  
  func cellForRowAt(at indexPath: IndexPath) -> User {
    return list[indexPath.row]
  }
}
