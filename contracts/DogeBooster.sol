pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DogeBooster is ERC20 {

  constructor(string memory name_, string memory symbol_) public ERC20(name_, symbol_) {
      _mint(0x1978b5B5D7A050c778390e1dDe24C50f59457147, 1000000000000 ether);
  }

  function burn(uint256 amount) external {
    _burn(msg.sender, amount);
  }

}
