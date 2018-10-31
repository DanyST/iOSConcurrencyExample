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
    @IBOutlet weak var syncFilterButton: UIButton!
    
    // Mark - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncFilterButton.isEnabled = false
        
        dispatchAsync()
        dispatchSync()
    }
    
    // MARK: - IBActions
    @IBAction func resetImages(_ sender: UIButton) {
        image01.image = UIImage(named: "Placeholder")
        image02.image = UIImage(named: "Placeholder")
        image03.image = UIImage(named: "Placeholder")
        image04.image = UIImage(named: "Placeholder")
        image05.image = UIImage(named: "Placeholder")
        image06.image = UIImage(named: "Placeholder")
        
        syncFilterButton.isEnabled = false
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
        
        // Dispatch group
        let group = DispatchGroup()
        
        // asignamos tareas asincronas a la cola
        
        // Lo añadimos al grupo.
        // Siempre debemos asegurarnos de que salga del grupo. Si no, nunca termina de esperar el DispatchGroup.
        group.enter()
        myConcurrentQueue.async {
            let data1 = try! Data(contentsOf: URL(string: self.imageURL01)!)
            
            DispatchQueue.main.async { [weak self] in
                self?.image01.image = UIImage(data: data1)
                group.leave()
            }
        }
        
        group.enter()
        myConcurrentQueue.async {
            let data2 = try! Data(contentsOf: URL(string: self.imageURL02)!)
            
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                
                self.image02.image = UIImage(data: data2)
                group.leave()
            }
        }
        
        group.enter()
        myConcurrentQueue.async {
            let data3 = try! Data(contentsOf: URL(string: self.imageURL03)!)
            DispatchQueue.main.async {
                self.image03.image = UIImage(data: data3)
                group.leave()
            }
        }
        
        group.enter()
        myConcurrentQueue.async {
            let data4 = try! Data(contentsOf: URL(string: self.imageURL04)!)
            DispatchQueue.main.async {
                self.image04.image = UIImage(data: data4)
                group.leave()
            }
            
        }
        
        group.enter()
        myConcurrentQueue.async {
            let data5 = try! Data(contentsOf: URL(string: self.imageURL05)!)
            DispatchQueue.main.async {
                self.image05.image = UIImage(data: data5)
                group.leave()
            }
        }
        
        group.enter()
        myConcurrentQueue.async {
            let data6 = try! Data(contentsOf: URL(string: self.imageURL06)!)
            DispatchQueue.main.async {
                self.image06.image = UIImage(data: data6)
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) { [weak self] in
            self?.syncFilterButton.isEnabled = true
        }
    }
    
    @IBAction func asyncDataDownload(_ sender: UIButton) {
        let asyncData1 = AsyncData(url: URL(string: imageURL01)!, id: "image01", defaultData: UIImage(named: "placeholder")!.pngData()!)
        
        asyncData1.delegate = self
        asyncData1.execute()
        
    }
    
    @IBAction func syncFilter(_ sender: UIButton) {
        
        // Creamos las operaciones
        let sepiaOp1 = SepiaFilterOperation()
        sepiaOp1.inputImage = self.image01.image
        
        let sepiaOp2 = SepiaFilterOperation()
        sepiaOp2.inputImage = self.image02.image
        
        let sepiaOp3 = SepiaFilterOperation()
        sepiaOp3.inputImage = self.image03.image
        
        let sepiaOp4 = SepiaFilterOperation()
        sepiaOp4.inputImage = self.image04.image
        
        let sepiaOp5 = SepiaFilterOperation()
        sepiaOp5.inputImage = self.image05.image
        
        let sepiaOp6 = SepiaFilterOperation()
        sepiaOp6.inputImage = self.image06.image
        
        // Creamos la OperationQueue
        let serialFilterQueue = OperationQueue()
        serialFilterQueue.maxConcurrentOperationCount = 6
        
       
        
        // Añadimos completionBlock de las operaciones
        sepiaOp1.completionBlock = { [weak self] in
            guard let output = sepiaOp1.outputImage else { return }
            
            DispatchQueue.main.async {
                self?.image01.image = output
            }
        }
        
        sepiaOp2.completionBlock = { [weak self] in
            guard let output = sepiaOp2.outputImage else { return }
            
            DispatchQueue.main.async {
                self?.image02.image = output
            }
        }
        
        sepiaOp3.completionBlock = { [weak self] in
            guard let output = sepiaOp3.outputImage else { return }
            
            DispatchQueue.main.async {
                self?.image03.image = output
            }
        }
        
        sepiaOp4.completionBlock = { [weak self] in
            guard let output = sepiaOp4.outputImage else { return }
            
            DispatchQueue.main.async {
                self?.image04.image = output
            }
        }
        
        sepiaOp5.completionBlock = { [weak self] in
            guard let output = sepiaOp5.outputImage else { return }
            
            DispatchQueue.main.async {
                self?.image05.image = output
            }
        }
        
        sepiaOp6.completionBlock = { [weak self] in
            guard let output = sepiaOp6.outputImage else { return }
            
            DispatchQueue.main.async {
                self?.image06.image = output
            }
        }
        
        // Añadimos las operaciones a la cola de OperationQueue
        serialFilterQueue.addOperations([sepiaOp1, sepiaOp2, sepiaOp3, sepiaOp4, sepiaOp5, sepiaOp6],
                                        waitUntilFinished: false)
        
    }
    
    // MARK: - Methods
    func dispatchAsync() {
        // Creamos la cola serial
        let serialQueue = DispatchQueue(label: "io.keepcoding.serial")
        
        var value = 42
        
        // definimos la tarea a ejecutar
        func changeValue() {
            sleep(1)
            value = 0
        }
        
        // añadimos la tarea asyncronamente a la cola serial
        print("----Dispatch Async")
        
        serialQueue.async {
            changeValue()
        }
        
        // mostramos el valor de value
        print(value)
    }
    
    func dispatchSync() {
        // Creamos la cola serial
        let serialQueue = DispatchQueue(label: "io.keepcoding.serial")
        
        var value = 42
        
        // definimos la tarea a ejecutar
        func changeValue() {
            sleep(1)
            value = 0
        }
        
        // añadimos la tarea asyncronamente a la cola serial
        
        print("----Dispatch Sync")
        serialQueue.sync {
            changeValue()
        }
        
        // mostramos el valor de value
        print(value)
    }
    
}

extension ViewController: AsyncDataDelegate {
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        let data = sender.data
        let image = UIImage(data: data)
        
        switch sender.id {
        case "image01":
            DispatchQueue.main.async {
                self.image01.image =  image
            }
        default:
            break
        }
    }
}

