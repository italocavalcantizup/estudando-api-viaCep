//
//  ViewController.swift
//  app-via-cep
//
//  Created by Italo cavalcanti on 09/11/22.
//

import UIKit

class ViaCepViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cepTextField: UITextField!
    
    var lista: ListaDeEnderecos?
    var endereco: Endereco?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "seeCepViewController" else { return }
        guard let destination = segue.destination as? CepViewController else {
            fatalError("Não foi possível executar a segue: \(segue.identifier!)")
        }
        if let _ = sender as? UIButton {
            realizarBusca(enviarPara: destination)
        }
        if let _ = sender as? MeusEnderecosViewCell {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let lista = lista {
                    destination.endereco = lista.lista[indexPath.row]
                }
            }
        }
    }
    
    func realizarBusca(enviarPara destination: CepViewController) {
        ViaCepAPI.buscaCep(cep: cepTextField.text!) { (endereco) in
            DispatchQueue.main.async {
                destination.endereco = endereco
            }
        }
    }
    
    func cepPreenchido() -> Bool {
        if let cep = cepTextField.text, !cep.isEmpty {
            return true
        }
        return false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let _ = sender as? UIButton, cepPreenchido() {
            return true
        }
        if let _ = sender as? MeusEnderecosViewCell {
            return true
        }
        return false
    }
}

extension ViaCepViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista?.lista.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "meusEnderecosViewCell") as? MeusEnderecosViewCell else {
            fatalError("Não foi possível obter célula para lista")
        }
        cell.endereco = lista?.lista[indexPath.row]
        return cell
    }
}

extension ViaCepViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
