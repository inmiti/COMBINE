//
//  ViewModelBoot.swift
//  ListaBootMVVMv1
//
//  Created by ibautista on 3/11/23.
//

import Foundation
import Combine

final class ViewModelBoot: ObservableObject {

    var modelStatusLoad: ((StatusLoad) -> Void)?    // El estado de la llamada de red ha cambiado
    
    //Model
    @Published var dataBoots: [BootCamps] = Array<BootCamps>() //inicializo a vacío
    var suscriptor = Set<AnyCancellable>()
    private var caseUse: CaseUseBootCamps
    
    init(caseUse: CaseUseBootCamps = CaseUseBootCamps()){
        self.caseUse = caseUse
        caseUse.$bootcamps
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.dataBoots = $0
            })
            .store(in: &suscriptor)
    }
    
    //Load function
    func getBootcamps() {
        // estado a loading
        modelStatusLoad?(.loading)
        
        // llama al caso de uso
        caseUse.loadBootCamps()
    }
}
 

//    func getBootcamps() {
//
//        let url = URL(string: "https://dragonball.keepcoding.education/api/data/bootcamps")!
//        var request: URLRequest = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared
//            .dataTaskPublisher(for: request)
//            .tryMap {
//                if $0.response.getStatusCode() == 200 {
//                    return $0.data
//                } else {
//                    throw URLError(.badServerResponse)
//                }
//            }
//            .decode(type: [BootCamps].self, decoder: JSONDecoder())
//            .replaceError(with: [])
////            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: {
//                self.dataBoots = $0
//            })
//            .store(in: &suscriptor)
//    }
//}
    
    
    
