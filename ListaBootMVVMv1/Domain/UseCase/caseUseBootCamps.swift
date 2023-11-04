//
//  BootUseCase.swift
//  ListaBootMVVMv1
//
//  Created by ibautista on 3/11/23.
//

import Foundation
import Combine

final class CaseUseBootCamps: ObservableObject {
    
    @Published var bootcamps: [BootCamps] = Array<BootCamps>()
    var suscriptor = Set<AnyCancellable>()
    
    func loadBootCamps() {
        
        let url = URL(string: "https://dragonball.keepcoding.education/api/data/bootcamps")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap {
                if $0.response.getStatusCode() == 200 {
                    return $0.data
                } else {
                    throw URLError(.badServerResponse)
                }
            }
            .decode(type: [BootCamps].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                self.bootcamps = $0
            })
            .store(in: &suscriptor)
    }
}


//TODO: Ver como mockear caso success y caso error
//final class CaseUseBootCampFakeSuccess: caseUseBootProtocol {
//    func loadBootCamps() -> [BootCamps] {
//        // Mock, ejectua despues de 3 seg
////        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////            let model = [ BootCamps(id: UUID(), name: "Boot1"),
////                          BootCamps(id: UUID(), name: "Boot2"),
////                          BootCamps(id: UUID(), name: "Boot3")
////                        ]
//            // Ejecuto closure con éxito:
////             model
////        }
//    }
//}
//
//    final class CaseUseBootCampFakeError: caseUseBootProtocol {
//        func loadBootCamps() -> [BootCamps] {
//            // Mock, ejectua despues de 3 seg
//            //        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            // Ejecuto closure con error:
//            //             []
//            //        }
//                }
//        }
//        
