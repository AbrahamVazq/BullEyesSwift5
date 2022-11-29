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
    @IBOutlet weak var nextRound: UIButton!
    @IBOutlet weak var record: UILabel!{ didSet{ record.isHidden = true }}
    @IBOutlet weak var newRecord: UILabel!{ didSet{ newRecord.isHidden = true}}
    
    //MARK: - V A R I A B L E S
    private var valorSlider: Int = 50
    private var valorObjetivo: Int = 0
    private var puntuacion: Int = 0
    private var ronda: Int = 1
    private var logro: Int = 0
    
   //MARK: - L Y F E · C Y C L E
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSlider()
        self.valorObjetivo = 1 + Int(arc4random_uniform(100))
        self.numberToAprox.text = "\(valorObjetivo)"
        self.round.text = "\(ronda)"
    }
    
    //MARK: - F U N C T I O N S
    private func setSlider(){
        numberToShoot.setThumbImage(UIImage(named: "SliderThumb-Normal"), for: .normal)
        numberToShoot.minimumValue = 1
        numberToShoot.maximumValue = 100
        numberToShoot.value = Float(valorSlider)
        numberToShoot.maximumTrackTintColor = .green
        numberToShoot.minimumTrackTintColor = .red
    }
    
    func initNewRound(){
        ronda += 1
        valorObjetivo = 1 + Int(arc4random_uniform(100))
        self.numberToAprox.text = "\(valorObjetivo)"
        valorSlider = 50
        numberToShoot.value = Float(valorSlider)
    }
    
    private func showAlert(withMessage msg: String){
        let alert = UIAlertController(title: "Tiro al Blanco", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - V A L I D A T I O N S
    private func evaluateValue(from value:Int) {
        let total = abs(value - valorObjetivo)
        switch total {
        case 0:
            self.showAlert(withMessage: "AH PERRILLO!")
            puntuacion += 100
            self.totalPoints.text = "\(puntuacion)"
            
        case 5,4,3,2,1:
            print("Maso maso")
            self.showAlert(withMessage: "Ufff casi Crack!")
            puntuacion += 50
            self.totalPoints.text = "\(puntuacion)"
            
        case 10,9,8,7,6:
            print("Dale de nuevo perro")
            self.showAlert(withMessage: "No mms, bien manco.")
        
        default:
            self.showAlert(withMessage: "Pon atencion cabron!.")
        }
    }
    
    private func showTotalPoint(withPoints points: Int){
        if points > logro {
            newRecord.isHidden = false
            newRecord.text = "Nueva puntuacion Maxima: \(points)"
            record.isHidden = false
            record.text = "Record: \(points)"
        }
        
    }
    
    private func showRecord(){
        
    }
    
    
    //MARK: - A C T I O N S
    @IBAction func sliderMoved(slider: UISlider) {
        valorSlider = lroundf(numberToShoot.value)
        print("El valor del slider is: \(valorSlider)")
    }
    
    @IBAction func goToEvaluate(_ sender: Any) {
        nextRound.isEnabled = !(ronda == 10)
        
        if ronda == 10 {
            self.showTotalPoint(withPoints: puntuacion)
        }
        
        self.shootNumber.isEnabled = false
        evaluateValue(from: valorSlider)
    }
    
    @IBAction func nextRound(_ sender: Any) {
        nextRound.isEnabled = !(ronda == 10)
        self.initNewRound()
        self.shootNumber.isEnabled = true
        self.round.text = "\(ronda)"
    }
    

}
