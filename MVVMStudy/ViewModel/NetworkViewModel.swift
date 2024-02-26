//
//  NetworkViewModel.swift
//  MVVMStudy
//
//  Created by Madeline on 2/26/24.
//

import Alamofire
import Foundation

class NetworkViewModel {
    
    var outputMarketList: Observable<[Market]> = Observable([])
    
    init() {
        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
                self.outputMarketList.value = success
            case .failure(_):
                print("🚨")
            }
        }
    }
    
}
