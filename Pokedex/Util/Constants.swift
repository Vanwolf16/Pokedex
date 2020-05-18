//
//  Constants.swift
//  Pokedex
//
//  Created by David Murillo on 5/15/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import Foundation
import UIKit

//URLs
let URL_BASE = "https://pokeapi.co"
let URL_POKEMON = URL_BASE + "/api/v2/pokemon"

struct Identifier {
    static let toPokeDetail = "toPokeDetail"
}

//Closure
typealias PokemonResponseCompletion = (PokeJSON?) -> Void
