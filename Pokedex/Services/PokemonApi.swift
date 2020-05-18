//
//  PokemonApi.swift
//  Pokedex
//
//  Created by David Murillo on 5/15/20.
//  Copyright © 2020 MuriTech. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PokemonApi{
    func getPokemon(url:String,completion:@escaping PokemonResponseCompletion){
        
        guard let url = URL(string: url) else {return}
        
        AF.request(url).responseJSON { (response) in
            if let error = response.error{
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
            //print(response.value)
            
            guard let data = response.data else {return completion(nil)}
            
            
            let jsonDecoder = JSONDecoder()
            do{
                let pokemon = try jsonDecoder.decode(PokeJSON.self, from: data)
                completion(pokemon)
            }catch{
                debugPrint(error.localizedDescription)
                completion(nil)
            }
            
        }
        
    }
}
