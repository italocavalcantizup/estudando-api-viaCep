//
//  ViaCepAPI.swift
//  app-via-cep
//
//  Created by Italo cavalcanti on 09/11/22.
//

import Foundation

class ViaCepAPI {
    
    static func buscaCep(cep: String, callback: @escaping (Endereco) -> Void) {
        guard let url = URL(string: "https://viacep.com.br/ws/\(cep)/json/") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    let cep = try JSONDecoder().decode(Endereco.self, from: data)
                    callback(cep)
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
    }
}
