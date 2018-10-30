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
        image01.image = UIImage(named: "Placeholder")
        image02.image = UIImage(named: "Placeholder")
        image03.image = UIImage(named: "Placeholder")
        image04.image = UIImage(named: "Placeholder")
        image05.image = UIImage(named: "Placeholder")
        image06.image = UIImage(named: "Placeholder")
    }
    
    @IBAction func privateQueueDownload(_ sender: UIButton) {
        // Creamos la cola Serial de trabajo
        let mySerialQueue = DispatchQueue(label: "io.keepcoding.serial")
        
        // asignamos tareas asincronas a la cola
        mySerialQueue.async {
            let data1 = try! Data(contentsOf: URL(string: self.imageURL01)!)
            
            DispatchQueue.main.async { [weak self] in
                self?.image01.image = UIImage(data: data1)
            }
        }
        
        mySerialQueue.async {
            let data2 = try! Data(contentsOf: URL(string: self.imageURL02)!)
            
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                
                self.image02.image = UIImage(data: data2)
            }
        }
        
        mySerialQueue.async {
            let data3 = try! Data(contentsOf: URL(string: self.imageURL03)!)
            DispatchQueue.main.async {
                self.image03.image = UIImage(data: data3)
            }
        }
        
        mySerialQueue.async {
            let data4 = try! Data(contentsOf: URL(string: self.imageURL04)!)
            DispatchQueue.main.async {
                self.image04.image = UIImage(data: data4)
            }
            
        }
        mySerialQueue.async {
            let data5 = try! Data(contentsOf: URL(string: self.imageURL05)!)
            DispatchQueue.main.async {
                self.image05.image = UIImage(data: data5)
            }
        }
        
        mySerialQueue.async {
            let data6 = try! Data(contentsOf: URL(string: self.imageURL06)!)
            DispatchQueue.main.async {
                self.image06.image = UIImage(data: data6)
            }
        }
    }
    
    @IBAction func privateQueueConcurrentDownload(_ sender: UIButton) {
        // Creamos la cola Concurrente de trabajo
//        let myConcurretQueue = DispatchQueue(label: "io.keepcoding.concurrent", attributes: .concurrent)
        // Salvo necesitemos identificar la cola con un label por alguna razón en particular, deberiamos utilizar las global Queue
        let myConcurrentQueue = DispatchQueue.global(qos: .userInitiated)
        
        
        // asignamos tareas asincronas a la cola
        
        myConcurrentQueue.async {
            let data1 = try! Data(contentsOf: URL(string: self.imageURL01)!)
            
            DispatchQueue.main.async { [weak self] in
                self?.image01.image = UIImage(data: data1)
            }
        }
        
        myConcurrentQueue.async {
            let data2 = try! Data(contentsOf: URL(string: self.imageURL02)!)
            
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                
                self.image02.image = UIImage(data: data2)
            }
        }
        
        myConcurrentQueue.async {
            let data3 = try! Data(contentsOf: URL(string: self.imageURL03)!)
            DispatchQueue.main.async {
                self.image03.image = UIImage(data: data3)
            }
        }
        
        myConcurrentQueue.async {
            let data4 = try! Data(contentsOf: URL(string: self.imageURL04)!)
            DispatchQueue.main.async {
                self.image04.image = UIImage(data: data4)
            }
            
        }
        myConcurrentQueue.async {
            let data5 = try! Data(contentsOf: URL(string: self.imageURL05)!)
            DispatchQueue.main.async {
                self.image05.image = UIImage(data: data5)
            }
        }
        
        myConcurrentQueue.async {
            let data6 = try! Data(contentsOf: URL(string: self.imageURL06)!)
            DispatchQueue.main.async {
                self.image06.image = UIImage(data: data6)
            }
        }
    }
    
    @IBAction func asyncDataDownload(_ sender: UIButton) {
    }
    
    
}

