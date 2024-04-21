//
//  ViewController.swift
//  ImageLoading
//
//  Created by Raj Joshi on 19/04/24.
//

import UIKit

class ImagesGallaryViewController: UIViewController {
    private let cache = NSCache<NSString, UIImage>() // Memory cache
    @IBOutlet var imgCollection: UICollectionView?
    @IBOutlet var loadingIndicator: UIActivityIndicatorView?
    var imagesDataModel: [ImagesModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HTTPRequest.fetchImages(API.BASE_URL) { response in
            self.loadingIndicator?.stopAnimating()
            self.imagesDataModel = response
            self.imgCollection?.reloadData()
        } failure: { errorMsg in
            self.loadingIndicator?.stopAnimating()
            //error Message *******
            debugPrint(errorMsg)
        }
    }
}

//MARK: CollectionView Delegate
extension ImagesGallaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesDataModel?.count ?? 0
    }
}
//MARK: CollectionView DataSource
extension ImagesGallaryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagesCollectionCell
        Helper.loadImage(from: Helper.imageURLString(imageModel: imagesDataModel?[indexPath.row])) { image in
            DispatchQueue.global().async {
                DispatchQueue.main.sync {
                    imgCell.imageView?.image = image
                    imgCell.loadingIndicator?.stopAnimating()
                }
            }
        }
        return imgCell
    }
}

//MARK: CollectionView Delegate Flow Layout
extension ImagesGallaryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalHeight: CGFloat = (self.view.frame.width / 3)
        let totalWidth: CGFloat = (self.view.frame.width / 3)
        return CGSize(width: totalWidth - 10, height: totalHeight - 10)
    }
}

class ImagesCollectionCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var loadingIndicator: UIActivityIndicatorView?
}

