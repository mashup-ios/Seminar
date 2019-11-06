
import UIKit


// MARK: - MVC ( apple's )

//struct Person { // Model 약해
//    let firstName: String
//    let lastName: String
////    let fdsigfbsd: String
//}
//
//class GreetingViewController : UIViewController { // View + Controller 강해
//    var person: Person!
//    let showGreetingButton = UIButton()
//    let greetingLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.showGreetingButton.addTarget(self, action: "didTapButton:", for: .touchUpInside)
//    }
//
//    func didTapButton(button: UIButton) {
//        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
//        self.greetingLabel.text = greeting
//
//    }
//    // layout code goes here
//}
//// Assembling of MVC
//let model = Person(firstName: "David", lastName: "Blaine")
//let view = GreetingViewController()
//view.person = model

// MARK: - MVP

//struct Person { // Model - 데이터처리
//    let firstName: String
//    let lastName: String
//
////    func getNaFN() -> String {
////        return ""
////    }
//}
//
//protocol GreetingView: class {
//    func setGreeting(greeting: String)
//}
//
//protocol GreetingViewPresenter {
//    init(view: GreetingView, person: Person)
//    func showGreeting()
//}
//
//class GreetingPresenter : GreetingViewPresenter { // Presenter - 연결 , 가공 , 전달
//    unowned let view: GreetingView
//    let person: Person
//    required init(view: GreetingView, person: Person) {
//        self.view = view
//        self.person = person
//    }
//    func showGreeting() {
//        // ! 가공
//        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
////        person.getNaFN()
//        self.view.setGreeting(greeting: greeting)
//    }
//
//    func cal() -> String {
////        self.view.setCal()
//        return "ndlsngkldsnknkl"
//
//    }
//}
//
//class GreetingViewController : UIViewController, GreetingView { // View - 사용자 액션 + 가공된 모델을 보여준다. - Model 책임 x
//    var presenter: GreetingViewPresenter!
//    let showGreetingButton = UIButton()
//    let greetingLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.showGreetingButton.addTarget(self, action: "didTapButton:", for: .touchUpInside)
//    }
//
//    func didTapButton(button: UIButton) {
//        self.presenter.showGreeting()
//    }
//
//    func setGreeting(greeting: String) {
//        self.greetingLabel.text = greeting
//    }
//
////    func cal() {
//////        presenter.cal()
////    }
//
//    // layout code goes here
//}
//// Assembling of MVP
//let model = Person(firstName: "David", lastName: "Blaine")
//let view = GreetingViewController()
//let presenter = GreetingPresenter(view: view, person: model)
//view.presenter = presenter


// MARK: - MVVM

struct Person { // Model
    let firstName: String
    let lastName: String
}

protocol GreetingViewModelProtocol: class {
    var greeting: String? { get }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())? { get set } // function to call when greeting did change
    init(person: Person)
    func showGreeting()
}

class GreetingViewModel : GreetingViewModelProtocol { // View Model - view 를 모르는 것이 핵심
    // Receiver
    // Data Binding -> View model 변경 => View 변경
    let person: Person
    var greeting: String? {
        didSet { // pro O
            self.greetingDidChange?(self)
        }
    }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())?

    required init(person: Person) {
        self.person = person
    }

    func showGreeting() {
        //
        self.greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
    }
    
    func update() {
        // Model update
//        self.gretting = updated Model
    }
}

class GreetingViewController : UIViewController { // View -
    // Invoker
    var viewModel: GreetingViewModelProtocol! {
        didSet {
            self.viewModel.greetingDidChange = { [unowned self] viewModel in
                // VM 변경 -> View 변경 // Data Binding
                // view 변경
                self.greetingLabel.text = viewModel.greeting
            }
        }
    }
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // command -> View Model
        self.showGreetingButton.addTarget(self.viewModel, action: "showGreeting", for: .touchUpInside)
    }
    // layout code goes here
    
    func update() {
        // Command -> View Model
        
    }
}
// Assembling of MVVM
let model = Person(firstName: "David", lastName: "Blaine")
let viewModel = GreetingViewModel(person: model)
let view = GreetingViewController()
view.viewModel = viewModel
