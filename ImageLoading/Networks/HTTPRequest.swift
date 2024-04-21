//
//  HTTP.swift
//  ImageLoading
//
//  Created by Raj Joshi on 19/04/24.
//

import Alamofire


class HTTPRequest {
    
    //MARK: Fetch Images data list
    static func fetchImages(_ api: String,
                            success: @escaping (_ response: [ImagesModel]) -> (),
                            failure: @escaping (_ errorMsg: String) -> ()) {
        AF.request(api, parameters: nil, requestModifier: {
            $0.timeoutInterval = API_REQUEST_TIME_OUT
        }
        ).responseDecodable(of: [ImagesModel].self)  { response in
            switch response.result {
            case .success(let responseData):
                success(responseData)
                break
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
