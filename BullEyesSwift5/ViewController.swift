//  ViewController.swift
//  BullEyesSwift5
//  Created by 291732 on 28/11/22.

import UIKit

class ViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var numberToAprox: UILabel!
    @IBOutlet weak var numberToShoot: UISlider!
    @IBOutlet weak var shootNumber: UIButton!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var round: UILabel!
    
    //MARK: - V A R I A B L E S
    private var valorSlider: Int = 50
    private var valorObjetivo: Int = 0
    private var puntuacion: Int = 0
    private var ronda: Int = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSlider()
        self.valorObjetivo = 1 + Int(arc4random_uniform(100))
        self.numberToAprox.text = "\(valorObjetivo)"
    }
    
    private func setSlider(){
        numberToShoot.setThumbImage(UIImage(named: "SliderThumb-Normal"), for: .normal)
        numberToShoot.minimumValue = 1
        numberToShoot.maximumValue = 100
        numberToShoot.value = Float(valorSlider)
        numberToShoot.maximumTrackTintColor = .green
        numberToShoot.minimumTrackTintColor = .red
    }
    
    /* Funcion que genera un nuevo Round */
    func iniciaNuevoRound(){
        ronda += 1
        valorObjetivo = 1 + Int(arc4random_uniform(100))
        valorSlider = 50
        numberToShoot.value = Float(valorSlider)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        valorSlider = lroundf(numberToShoot.value)
        print("El valor del slider is: \(valorSlider)")
    }
    
    @IBAction func goToEvaluate(_ sender: Any) {
        self.shootNumber.isEnabled = false
        evaluateValue(from: valorSlider)
    }
    
    private func evaluateValue(from value:Int) {
        let total = abs(value - valorObjetivo)
        switch total {
        case 0:
            print("AH PERRILLO!")
            puntuacion += 100
            self.totalPoints.text = "\(puntuacion)"
            
        case 5,4,3,2,1:
            print("Maso maso")
            puntuacion += 50
            self.totalPoints.text = "\(puntuacion)"
            
        case 10,9,8,7,6:
            print("Dale de nuevo perro")
        
        default:
            break

        }
    }
    
    


}
