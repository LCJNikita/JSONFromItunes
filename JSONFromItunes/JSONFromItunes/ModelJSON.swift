//
//  ModelJSON.swift
//  JSONFromItunes
//
//  Created by Никита Кузнецов on 18/10/2019.
//  Copyright © 2019 bykuznetsov. All rights reserved.
//

import Foundation

struct Model: Decodable{
    var resultCount:Int
    var results:[ModelSong]
}

struct ModelSong: Decodable{
    var artistName:String
    var trackName:String
    var collectionName:String?
    var artworkUrl60:String?
}
