//
//  ViewController.swift
//  ConcurrencyExample
//
//  Created by Luis Herrera Lillo on 29-10-18.
//  Copyright © 2018 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let imageURL01 = "https://image.tmdb.org/t/p/original/cezWGskPY5x7GaglTTRN4Fugfb8.jpg"
    let imageURL02 = "https://image.tmdb.org/t/p/original/t90Y3G8UGQp0f0DrP60wRu9gfrH.jpg"
    let imageURL03 = "https://image.tmdb.org/t/p/original/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg"
    let imageURL04 = "https://image.tmdb.org/t/p/original/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"
    let imageURL05 = "https://image.tmdb.org/t/p/original/rv1AWImgx386ULjcf62VYaW8zSt.jpg"
    let imageURL06 = "https://image.tmdb.org/t/p/original/uB1k7XsHvjjJXSAwur37wttrzpJ.jpg"
    
    // Mark - Outlets
    @IBOutlet weak var image01: UIImageView!
    @IBOutlet weak var image02: UIImageView!
    @IBOutlet weak var image03: UIImageView!
    @IBOutlet weak var image04: UIImageView!
    @IBOutlet weak var image05: UIImageView!
    @IBOutlet weak var image06: UIImageView!
    
    // Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    @IBAction func resetImages(_ sender: UIButton) {
    }
    
    @IBAction func privateQueueDownload(_ sender: UIButton) {
    }
    @IBAction func privateQueueConcurrentDownload(_ sender: UIButton) {
    }
    
    @IBAction func asyncDataDownload(_ sender: UIButton) {
    }
    
    
}

