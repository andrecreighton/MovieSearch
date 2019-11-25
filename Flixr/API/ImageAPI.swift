//
//  ImageAPI.swift
//  Flixr
//
//  Created by Andre Creighton on 10/23/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation
import UIKit

struct MovieImage {
  
  enum Size: String {
    case small = "https://image.tmdb.org/t/p/w154/"
    case medium = "https://image.tmdb.org/t/p/w500/"
    case original = "https://image.tmdb.org/t/p/original/"
    
    func path(poster: String) -> URL {
          return URL(string: rawValue)!.appendingPathComponent(poster)
      }
    
  }
  
  
  func imageUrl(_ poster: String, _ size: Size) -> URL? {
    return size.path(poster: poster)
  }
  
  
}
