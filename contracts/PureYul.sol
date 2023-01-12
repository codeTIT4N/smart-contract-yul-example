// Solidity function:
// function collatzIteration(uint256 n) public pure override returns (uint256) {
//   if (n % 2 == 0) {
//     return n / 2;
//   } else {
//     return 3 * n + 1;
//   }
// }

object "PureYul" {
	code {
		// constructor
		datacopy(0, dataoffset("runtime"), datasize("runtime"))
		return(0, datasize("runtime"))
	}

	object "runtime" {
		code {
			switch selector()
			case 0xee924223 /* collatzIteration(uint256) */ {
				returnUint(calculate(decodeAsUint(0)))
			}
			default {
				revert(0, 0)
			}

			/* ---------- calldata decoding functions ----------- */
            function selector() -> s {
                s := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
            }

            function decodeAsUint(offset) -> v {
                let pos := add(4, mul(offset, 0x20))
                if lt(calldatasize(), add(pos, 0x20)) {
                    revert(0, 0)
                }
                v := calldataload(pos)
            }
			/* ---------- calldata encoding functions ---------- */
			function returnUint(v) {
                mstore(0, v)
                return(0, 0x20)
            }

			function calculate(n) -> result {
				switch mod(n,2)
					case 0 { result := div(n,2) }
					default { result := add(mul(3,n),1) }
			}
		}
	}
}
