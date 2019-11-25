//
//  Movie.swift
//  Flixr
//
//  Created by Andre Creighton on 10/23/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import Foundation

struct Movie {
  
  var id : Int
  var title : String
  var overview : String
  var releaseDate : String
  var posterPath : String
  var backdropPath : String
    
  init(){
    
    self.id = 0
    self.title = ""
    self.overview = ""
    self.releaseDate = ""
    self.posterPath = ""
    self.backdropPath = ""
    
  }

  
  init(id: Int, title : String, overview: String, releaseDate: String, posterPath: String, backdropPath: String){
    
    self.id = id
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
    self.posterPath = posterPath
    self.backdropPath = backdropPath
      
  }

  init(_ info:[String:Any]) {
    
    self.id = info["id"] as! Int
    self.title = info["title"] as! String
    self.overview = info["overview"] as! String
    self.releaseDate = info["release_date"] as? String ?? ""
    self.posterPath = info["poster_path"] as? String ?? ""
    self.backdropPath = info["backdrop_path"] as? String ?? ""
    
    //return Movie(id: id, title: title, overview: overview, releaseDate: releaseDate, posterPath: posterPath, backdropPath: backdropPath)
  }

}

