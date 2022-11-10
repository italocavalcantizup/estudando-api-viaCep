//
//  Address.swift
//  app-via-cep
//
//  Created by Italo cavalcanti on 09/11/22.
//

import Foundation

struct Endereco: Codable {
    var apelido: String?
    var cep: String
    var logradouro: String
    var bairro: String
    var localidade: String
    var uf: String
    var numero: Int?
    var complemento: String?
}

struct ListaDeEnderecos {
    var lista: [Endereco] = [
        Endereco(apelido: "Casa", cep: "01000100", logradouro: "Rua numero um", bairro: "Jd. Bairro", localidade: "São Paulo", uf: "SP"),
        Endereco(apelido: "Escola", cep: "02000140", logradouro: "Rua numero dois", bairro: "Jd. Bairro", localidade: "São Bernardo do Campo", uf: "SP"),
        Endereco(apelido: "Trabalho", cep: "03000100", logradouro: "Rua numero tres", bairro: "Jd. Bairro", localidade: "Diadema", uf: "SP"),
        Endereco(apelido: "Faculdade", cep: "04000100", logradouro: "Rua numero quatro", bairro: "Jd. Bairro", localidade: "Santo André", uf: "SP"),
    ]
    
    mutating func salvarEndereco(_ endereco: Endereco) {
        lista.append(endereco)
    }
}
