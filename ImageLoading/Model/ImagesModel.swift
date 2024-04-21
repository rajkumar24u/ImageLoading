//
//  ImagesModel.swift
//  ImageLoading
//
//  Created by Raj Joshi on 19/04/24.
//

import Foundation

// MARK: - ImageElement
struct ImagesModel: Codable {
    let id, title: String?
    let language: Language?
    let thumbnail: Thumbnail?
    let mediaType: Int?
    let coverageURL: String?
    let publishedAt, publishedBy: String?
    let backupDetails: BackupDetails?
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
    let pdfLink: String?
    let screenshotURL: String?
}

enum Language: String, Codable {
    case english
    case hindi
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let id: String?
    let version: Int?
    let domain: String?
    let basePath: String?
    let key: String?
    let qualities: [Int]?
    let aspectRatio: Int?
}

