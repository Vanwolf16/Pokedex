//
//  PokeJSON.swift
//  Pokedex
//
//  Created by David Murillo on 5/15/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import Foundation
import UIKit

//Note to self do CodingKeys to finish the missing parts

struct PokeJSON:Codable{
    let name:String
    let weight:Int
    let height:Int
    let types:[Type]
    /*
    let pokedexId:Int
    let description:String
    let type:String
    let defense:String
    let height:String
    let weight:String
    let attack:String
    let nextEvoTxt:String
    */
}

struct Type:Codable {
    let slot:Int
    let type:FullType!
}

struct FullType:Codable{
    let name:String
    let url:String
}
