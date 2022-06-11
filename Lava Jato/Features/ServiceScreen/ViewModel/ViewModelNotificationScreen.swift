//
//  ViewModel.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 04/05/22.
//

import UIKit

class ViewModelServices {
    
    private var data:[Profile] = []
    private var dataService:[ProfileService] = []
    
    func appendData(){
        self.data.append(Profile.init(name: "Bruno Polimentos", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2315 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Completa "))
        self.data.append(Profile.init(name: "José LavaJato", photo: UIImage(imageLiteralResourceName: "profile2"), adress: "Endereço: Rua numero, 121 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples "))
        self.data.append(Profile.init(name: "Thiago Cristalização", photo: UIImage(imageLiteralResourceName: "profile3"), adress: "Endereço: Rua numero, 1123 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Polimento e Cristalização "))
        self.data.append(Profile.init(name: "Lavagens&Estética", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2221 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples "))
        self.dataService.append(ProfileService.init(name: "José", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2221 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples "))
        self.dataService.append(ProfileService.init(name: "Glauber", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2221 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples "))
        self.dataService.append(ProfileService.init(name: "Antonio", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2221 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples "))
    }
    
    public func loadCellUser(indexPath:IndexPath)->Profile{
        return self.data[indexPath.row]
    }
    
    public func loadCellService(indexPath:IndexPath)->ProfileService{
        return self.dataService[indexPath.row]
    }
    
    public var countElementsArray:Int{
        return self.data.count
    }
    public var countElementsService:Int{
        return self.dataService.count
    }
    
    public func countCells(segment:UISegmentedControl) -> Int{
        switch segment.selectedSegmentIndex {
        case 0:
            return self.data.count
        case 1:
            return self.dataService.count
        default:
            break
        }
        return 0
    }
    
    public func removeIndexData(indexPath:IndexPath){
        self.data.remove(at: indexPath.row)
    }
    public func removeIndexService(indexPath:IndexPath){
        self.dataService.remove(at: indexPath.row)
    }
    
    public var heightForRow:CGFloat{
        return 200
    }
}
