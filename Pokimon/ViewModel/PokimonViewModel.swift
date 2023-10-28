//
//  PokimonViewModel.swift
//  Pokimon
//
//  Created by Mohamed Salah on 28/10/2023.
//

import Foundation
import SwiftUI
import Alamofire

class PokimonViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var list: [Pokimon] = [Pokimon]()
    @Published var secoundList: [String] = [String]()
    
    func getResturantMenu(){
        NetworkManager.shared.execute(requestRoute: .pokimonData(request: "https://pokeapi.co/api/v2/pokemon"), responseModel: PokimonData.self, isLoaderActive: false) { result in
            switch result {
            case .success(let response):
                self.getNames(pokimonData: response!)
//                self.convertToPokimon(pokimonData: response!)
//                print(self.list)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    func getPokimon(url: String){
        NetworkManager.shared.execute(requestRoute: .pokimon(request: url), responseModel: Pokimon.self, isLoaderActive: false) { result in
            switch result {
            case .success(let response):
                self.list.append(response!)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    func convertToPokimon(pokimonData: PokimonData) {
        for pokimon in pokimonData.results {
            print(pokimon.url)
            getPokimon(url: pokimon.url)
        }
    }
    func getNames(pokimonData: PokimonData) {
        for pokimon in pokimonData.results {
            secoundList.append(pokimon.name)
        }
    }
}
