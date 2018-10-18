class Node {
    var x = Int()
    var y = Int()
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func isNeighbor(second: Node) -> Bool {
        var result = true
        if self.x == second.x || self.y == second.y {
            result = true
        } else if (Double(self.y) - Double(second.y))/(Double(self.x) - Double(second.x)) == -1.0 {
            result = true
        } else if (Double(self.y) - Double(second.y))/(Double(self.x) - Double(second.x)) == 1.0 {
            result = true
        } else {
            result = false
        }
        return result
    }
    
    func isFree(fellowNodes: [Node]) -> Bool {
        for node in fellowNodes {
            if isNeighbor(second: node) {
                return false
            }
        }
        
        return true
    }
}

func place(past: [Node], count: Int) -> ([Node], Bool) {
    var result = past
    var success = false
    
    if count == 25 {
        return (result, true)
    } else {
        var height = [Int]() // To make array to check in descending to the bottom then ascending to the top order
        height.append(count) // The tendency of this is that the first half will be below the slope line from 0,0 to 24, 24
        for i in 0...23 {    // and the second half will be above that line.
            if i + count <= 24 {
                height.append(count + i)
            } else {
                height.append(24 - i)
            }
        }
        
        for i in 0...24 {
            let current = Node(x: count, y: height[i])
            
            if current.isFree(fellowNodes: past) {
                var temp = past
                temp.append(current)
                (temp, success) = place(past: temp, count: count + 1)
                if success {
                    result = temp
                    return (result, success)
                }
            }
        }
        return (past, success)
    }
}

// Main Execution
print("Question 1")

var queens = [Node]()
var success = Bool()
(queens, success) = place(past: queens, count: 0)

// Make Board
var board = Array<Array<String>>()
for _ in 0...24 {
    board.append(Array(repeating: "_ ", count: 25))
}

// Set the Board
for queen in queens {
    board[queen.x][queen.y] = "Q "
}

// Print the Board
for i in 0...24 {
    var result = ""
    for j in 0...24 {
        result = result + board[j][i]
    }
    print(result)
}
