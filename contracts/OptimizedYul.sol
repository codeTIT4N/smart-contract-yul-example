// Solidity function:
// function collatzIteration(uint256 n) public pure override returns (uint256) {
//   if (n % 2 == 0) {
//     return n / 2;
//   } else {
//     return 3 * n + 1;
//   }
// }

object "OptimizedYul" {
	code {
		// constructor
		datacopy(0, dataoffset("runtime"), datasize("runtime"))
		return(0, datasize("runtime"))
	}

	object "runtime" {
		code {
			switch div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
			case 0xee924223 /* collatzIteration(uint256) */ {
                switch mod(calldataload(add(4, mul(0, 0x20))),2)
					case 0 { 
                        mstore(0, div(calldataload(add(4, mul(0, 0x20))),2))
                    }
					default { 
                        mstore(0, add(mul(3,calldataload(add(4, mul(0, 0x20)))),1))
                    }
                return(0, 0x20)
			}
			default {
				revert(0, 0)
			}
		}
	}
}
