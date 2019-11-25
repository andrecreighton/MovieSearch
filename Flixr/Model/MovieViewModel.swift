//
//  MovieViewModel.swift
//  Flixr
//
//  Created by Andre Creighton on 10/23/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation
import UIKit

struct MovieViewModel {
  
  var movie : Movie
  var imageOfMovie : UIImage?
  
  init(movie: Movie) {
    self.movie = movie
  }

  var title: String{
    self.movie.title + " "
  }
  
  var overview: String{
    self.movie.overview
  }
  
  var releaseDate: String{
    self.movie.releaseDate
  }
  
  var imageUrl : URL? {
    let mI = MovieImage()
    return mI.imageUrl(self.movie.posterPath, .small)
  }
  
  var imageBackdropUrl : URL? {
    let mI = MovieImage()
    return mI.imageUrl(self.movie.backdropPath, .original)
  }
  
  
}
