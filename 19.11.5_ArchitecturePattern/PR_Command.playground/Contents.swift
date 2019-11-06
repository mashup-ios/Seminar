import UIKit

// MARK: - Receiver
public class Door {
    public var isOpen = false
}

// MARK: - Command
public class DoorCommand {
  public let door: Door
  public init(_ door: Door) {
    self.door = door
  }
  public func execute() { }
}

public class OpenCommand: DoorCommand { // 변경
  public override func execute() {
    print("opening the door...")
    door.isOpen = true
  }
}

public class CloseCommand: DoorCommand {
  public override func execute() {
    print("closing the door...")
    door.isOpen = false
  }
}


// MARK: - Invoker
public class Doorman {

  public let commands: [DoorCommand]
  public let door: Door
    
//    door.isopen = true

  public init(door: Door) {
    // 액션들이 미리 생성이 된다.
    let commandCount = arc4random_uniform(10) + 1
    self.commands = (0 ..< commandCount).map { index in
      return index % 2 == 0 ?
        OpenCommand(door) : CloseCommand(door)
        // o c o c o
        // c o c o
        
    }
    self.door = door
  }

  public func execute() {
    print("Doorman is...")
    commands.forEach { $0.execute() }
  }
}

let door = Door()
let doorMan = Doorman(door: door)
//doorMan.execute()

// 장점
// 액션이 저장된 이후 호출은 나중에 되어야 할때
// 행동이 아닌 행동에 의한 액션이 변경되는 경우 큰 이점이 있다. - 의존성이 낮기 때문에
// 단점
// 읽기 어려울 수 있다.
