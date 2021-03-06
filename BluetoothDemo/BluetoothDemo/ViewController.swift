//
//  ViewController.swift
//  BluetoothDemo
//
//  Created by Amar Shirke on 09/07/21.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    var centralManager: CBCentralManager?
    var peripherals = Array<CBPeripheral>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialise CoreBluetooth Central Manager
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
        
        
    }
}

extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn){
            self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            // do something like alert the user that ble is not on
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripherals.append(peripheral)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let peripheral = peripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name
        print(peripherals)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
}

