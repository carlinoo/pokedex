//
//  Pokemon.swift
//  Pokedex
//
//  Created by mac on 05/08/2017.
//  Copyright © 2017 Carlos Gonzalez. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTXT: String!
    private var _pokemonURL: String!

    
    // Setters and Getters
    
    
    var name: String {
        get {
            return _name
        } set {
            _name = newValue
        }
    }
    
    
    var pokedexID: Int {
        
        get {
            return _pokedexID
        } set {
            _pokedexID = newValue
        }
    }
    
    
    var type: String {
        get {
            if self._type == nil {
                self._type = ""
            }
            
            return self._type
        } set {
            self._type = type
        }
    }
    
    var defense: String {
        get {
            if _defense == nil {
                _defense = ""
            }
            
            return _defense
        }
    }
    
    var weight: String {
        get {
            if _weight == nil {
                _weight = ""
            }
            
            return _weight
        }
    }
    
    var attack: String {
        get {
            if _attack == nil {
                _attack = ""
            }
            
            return _attack
        }
    }
    
    var height: String {
        get {
            if _height == nil {
                _height = ""
            }
            
            return _height
        }
    }
    
    
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            
            return _description
        }
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(BASE_URL)\(URL_POKEMON)\(self.pokedexID)"
    }
    
    // Download Details
    func downloadPokemonDetail(completed: @escaping DowloadComplete) {
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                // Attatck value
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                
                // Defense value
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                
                // Height value
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                // Weight value
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                // Types values
                if let types = dict["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for i in 1..<types.count {
                            if let name = types[i]["name"] as? String {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } // end types
                
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, AnyObject>], descriptionArray.count > 0 {
                    if let url = descriptionArray[0]["resource_uri"] {
                        Alamofire.request("\(BASE_URL)\(url)").responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                }
                            }
                            
                            completed()
                        })
                    }
                }
                
                
            }
            completed()
        }
    }
    
    
}
