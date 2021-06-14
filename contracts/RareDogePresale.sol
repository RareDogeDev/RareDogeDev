pragma solidity ^0.6.12;


// SPDX-License-Identifier: Unlicensed
interface IERC20 {

    function decimals() external view returns(uint256);

    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}



/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}


/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;
    address private _previousOwner;
    uint256 private _lockTime;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

     /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    function geUnlockTime() public view returns (uint256) {
        return _lockTime;
    }

    //Locks the contract for owner for the amount of time provided
    function lock(uint256 time) public virtual onlyOwner {
        _previousOwner = _owner;
        _owner = address(0);
        _lockTime = now + time;
        emit OwnershipTransferred(_owner, address(0));
    }

    //Unlocks the contract for owner when _lockTime is exceeds
    function unlock() public virtual {
        require(_previousOwner == msg.sender, "You don't have permission to unlock");
        require(now > _lockTime , "Contract is locked until 7 days");
        emit OwnershipTransferred(_owner, _previousOwner);
        _owner = _previousOwner;
    }
}

interface IPancakeV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IPancakeV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IPancakePair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}


contract RareDogePresale is Context, Ownable {
    using SafeMath for uint256;
    using Address for address;

    address public rareToken;
    IPancakeV2Factory public pancakeFactory;
    address public WETH;
    address public usdPair;
    mapping (address => address) public tokenList;
    uint256 public presaleTimer;

    mapping (address => bool) public investedList;
    uint256 public totalParticipants;
    uint256 public totalSold;
    uint256 public totalBNBRaised;
    mapping (address => uint256) public balances;

    event purchase(address user, uint256 amount);

    constructor(address _rareToken, address _weth, address _factory, address _usd) public {
      rareToken = _rareToken;
      WETH = _weth;
      pancakeFactory = IPancakeV2Factory(_factory);
      if(pancakeFactory.getPair(WETH, _usd) == address(0)){
        pancakeFactory.createPair(_usd, WETH);
      }
      usdPair = pancakeFactory.getPair(WETH, _usd);
      tokenList[_usd] = pancakeFactory.getPair(WETH, _usd); //USDC
      tokenList[0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d] = pancakeFactory.getPair(WETH, 0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d); //USDC
      tokenList[0x47BEAd2563dCBf3bF2c9407fEa4dC236fAbA485A] = pancakeFactory.getPair(WETH, 0x47BEAd2563dCBf3bF2c9407fEa4dC236fAbA485A); //SXP
      tokenList[0x0Da6Ed8B13214Ff28e9Ca979Dd37439e8a88F6c4] = pancakeFactory.getPair(WETH, 0x0Da6Ed8B13214Ff28e9Ca979Dd37439e8a88F6c4); //STAX
      tokenList[0xA8c2B8eec3d368C0253ad3dae65a5F2BBB89c929] = pancakeFactory.getPair(WETH, 0xA8c2B8eec3d368C0253ad3dae65a5F2BBB89c929); //STK
      tokenList[0x0D8Ce2A99Bb6e3B7Db580eD848240e4a0F9aE153] = pancakeFactory.getPair(WETH, 0x0D8Ce2A99Bb6e3B7Db580eD848240e4a0F9aE153); //FIL
      tokenList[0xBf5140A22578168FD562DCcF235E5D43A02ce9B1] = pancakeFactory.getPair(WETH, 0xBf5140A22578168FD562DCcF235E5D43A02ce9B1); //UNI
      tokenList[0x88f1A5ae2A3BF98AEAF342D26B30a79438c9142e] = pancakeFactory.getPair(WETH, 0x88f1A5ae2A3BF98AEAF342D26B30a79438c9142e); //YFI
      tokenList[0x8fF795a6F4D97E7887C79beA79aba5cc76444aDf] = pancakeFactory.getPair(WETH, 0x8fF795a6F4D97E7887C79beA79aba5cc76444aDf); //BCH
      tokenList[0x16939ef78684453bfDFb47825F8a5F714f12623a] = pancakeFactory.getPair(WETH, 0x16939ef78684453bfDFb47825F8a5F714f12623a); //TEZ
      tokenList[0x1AF3F329e8BE154074D8769D1FFa4eE058B1DBc3] = pancakeFactory.getPair(WETH, 0x1AF3F329e8BE154074D8769D1FFa4eE058B1DBc3); //DAI
      tokenList[0xC9849E6fdB743d08fAeE3E34dd2D1bc69EA11a51] = pancakeFactory.getPair(WETH, 0xC9849E6fdB743d08fAeE3E34dd2D1bc69EA11a51); //PBUN
      tokenList[0x190b589cf9Fb8DDEabBFeae36a813FFb2A702454] = pancakeFactory.getPair(WETH, 0x190b589cf9Fb8DDEabBFeae36a813FFb2A702454); //BDOL
      tokenList[0x947950BcC74888a40Ffa2593C5798F11Fc9124C4] = pancakeFactory.getPair(WETH, 0x947950BcC74888a40Ffa2593C5798F11Fc9124C4); //SUSH
      tokenList[0x8076C74C5e3F5852037F31Ff0093Eeb8c8ADd8D3] = pancakeFactory.getPair(WETH, 0x8076C74C5e3F5852037F31Ff0093Eeb8c8ADd8D3); //SAFE
      tokenList[0x52CE071Bd9b1C4B00A0b92D298c512478CaD67e8] = pancakeFactory.getPair(WETH, 0x52CE071Bd9b1C4B00A0b92D298c512478CaD67e8); //COMP
      tokenList[0x762539b45A1dCcE3D36d080F74d1AED37844b878] = pancakeFactory.getPair(WETH, 0x762539b45A1dCcE3D36d080F74d1AED37844b878); //LINA
      tokenList[0x63870A18B6e42b01Ef1Ad8A2302ef50B7132054F] = pancakeFactory.getPair(WETH, 0x63870A18B6e42b01Ef1Ad8A2302ef50B7132054F); //BLINK
      tokenList[0x5Ac52EE5b2a633895292Ff6d8A89bB9190451587] = pancakeFactory.getPair(WETH, 0x5Ac52EE5b2a633895292Ff6d8A89bB9190451587); //BSCX
      tokenList[0xf859Bf77cBe8699013d6Dbc7C2b926Aaf307F830] = pancakeFactory.getPair(WETH, 0xf859Bf77cBe8699013d6Dbc7C2b926Aaf307F830); //BERRY
      tokenList[0x3EE2200Efb3400fAbB9AacF31297cBdD1d435D47] = pancakeFactory.getPair(WETH, 0x3EE2200Efb3400fAbB9AacF31297cBdD1d435D47); //ADA
      tokenList[0xAD6cAEb32CD2c308980a548bD0Bc5AA4306c6c18] = pancakeFactory.getPair(WETH, 0xAD6cAEb32CD2c308980a548bD0Bc5AA4306c6c18); //BAND
      tokenList[0x7083609fCE4d1d8Dc0C979AAb8c869Ea2C873402] = pancakeFactory.getPair(WETH, 0x7083609fCE4d1d8Dc0C979AAb8c869Ea2C873402); //DOT
      tokenList[0x56b6fB708fC5732DEC1Afc8D8556423A2EDcCbD6] = pancakeFactory.getPair(WETH, 0x56b6fB708fC5732DEC1Afc8D8556423A2EDcCbD6); //EOS
      tokenList[0xF8A0BF9cF54Bb92F17374d9e9A321E6a111a51bD] = pancakeFactory.getPair(WETH, 0xF8A0BF9cF54Bb92F17374d9e9A321E6a111a51bD); //LINK
      tokenList[0x55d398326f99059fF775485246999027B3197955] = pancakeFactory.getPair(WETH, 0x55d398326f99059fF775485246999027B3197955); //TUSD
      tokenList[0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56] = pancakeFactory.getPair(WETH, 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56); //BUSD
      tokenList[0x4B0F1812e5Df2A09796481Ff14017e6005508003] = pancakeFactory.getPair(WETH, 0x4B0F1812e5Df2A09796481Ff14017e6005508003); //TWT
      tokenList[0xcF6BB5389c92Bdda8a3747Ddb454cB7a64626C63] = pancakeFactory.getPair(WETH, 0xcF6BB5389c92Bdda8a3747Ddb454cB7a64626C63); //VENUS
      tokenList[0x2170Ed0880ac9A755fd29B2688956BD959F933F8] = pancakeFactory.getPair(WETH, 0x2170Ed0880ac9A755fd29B2688956BD959F933F8); //BETH
      tokenList[0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c] = pancakeFactory.getPair(WETH, 0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c); //BBTC
      tokenList[0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82] = pancakeFactory.getPair(WETH, 0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82); //CAKE
      tokenList[0x250632378E573c6Be1AC2f97Fcdf00515d0Aa91B] = pancakeFactory.getPair(WETH, 0x250632378E573c6Be1AC2f97Fcdf00515d0Aa91B); //BEACON
      tokenList[0xa184088a740c695E156F91f5cC086a06bb78b827] = pancakeFactory.getPair(WETH, 0xa184088a740c695E156F91f5cC086a06bb78b827); //AUTOV2
      tokenList[0x1f546aD641B56b86fD9dCEAc473d1C7a357276B7] = pancakeFactory.getPair(WETH, 0x1f546aD641B56b86fD9dCEAc473d1C7a357276B7); //PANTHER
      tokenList[0xa9c41A46a6B3531d28d5c32F6633dd2fF05dFB90] = pancakeFactory.getPair(WETH, 0xa9c41A46a6B3531d28d5c32F6633dd2fF05dFB90); //WALNUT
      tokenList[0xF952Fc3ca7325Cc27D15885d37117676d25BfdA6] = pancakeFactory.getPair(WETH, 0xF952Fc3ca7325Cc27D15885d37117676d25BfdA6); //GOOSE
      tokenList[0x4BD17003473389A42DAF6a0a729f6Fdb328BbBd7] = pancakeFactory.getPair(WETH, 0x4BD17003473389A42DAF6a0a729f6Fdb328BbBd7); //VAI
      tokenList[0x1D2F0da169ceB9fC7B3144628dB156f3F6c60dBE] = pancakeFactory.getPair(WETH, 0x1D2F0da169ceB9fC7B3144628dB156f3F6c60dBE); //XRP
      tokenList[0x603c7f932ED1fc6575303D8Fb018fDCBb0f39a95] = pancakeFactory.getPair(WETH, 0x603c7f932ED1fc6575303D8Fb018fDCBb0f39a95); //APE
      tokenList[0x101d82428437127bF1608F699CD651e6Abf9766E] = pancakeFactory.getPair(WETH, 0x101d82428437127bF1608F699CD651e6Abf9766E); //BAT
      tokenList[0x4338665CBB7B2485A8855A139b75D5e34AB0DB94] = pancakeFactory.getPair(WETH, 0x4338665CBB7B2485A8855A139b75D5e34AB0DB94); //LTC
      tokenList[0xbA2aE424d960c26247Dd6c32edC70B295c744C43] = pancakeFactory.getPair(WETH, 0xbA2aE424d960c26247Dd6c32edC70B295c744C43); //DOGE
      tokenList[0x7A9f28EB62C791422Aa23CeAE1dA9C847cBeC9b0] = pancakeFactory.getPair(WETH, 0x7A9f28EB62C791422Aa23CeAE1dA9C847cBeC9b0); //YIELD
      tokenList[0x05B339B0A346bF01f851ddE47a5d485c34FE220c] = pancakeFactory.getPair(WETH, 0x05B339B0A346bF01f851ddE47a5d485c34FE220c); //ASTRO
      tokenList[0xCa3F508B8e4Dd382eE878A314789373D80A5190A] = pancakeFactory.getPair(WETH, 0xCa3F508B8e4Dd382eE878A314789373D80A5190A); //BEEFY
    }

    function addToken(address _tokenAddress) public onlyOwner {
      tokenList[_tokenAddress] = pancakeFactory.getPair(WETH, _tokenAddress);
    }

    function removeToken(address _tokenAddress) public onlyOwner {
      tokenList[_tokenAddress] = address(0);
    }

    function setTimer(uint256 newTime) public onlyOwner {
      presaleTimer = newTime;
    }

    function buyToken() external payable {
      require(presaleTimer > block.timestamp, "Presale Ended");
      require(msg.value >= 0.01 ether, "Funds Below Minimum Buy");

      if(!investedList[msg.sender]){
        investedList[msg.sender] = true;
        totalParticipants++;
      }

      totalBNBRaised += msg.value;
      totalSold += msg.value.mul(1 ether).div(getUSDValue());
      balances[msg.sender] = balances[msg.sender].add(msg.value.mul(1 ether).div(getUSDValue()));
      payable(owner()).transfer(msg.value);
      //IERC20(rareToken).transfer(msg.sender, msg.value.div(getUSDValue()));
      emit purchase(msg.sender, msg.value.mul(1 ether).div(getUSDValue()));
    }

    function buyTokenWithToken(address _token, uint256 _amount) external {
      require(presaleTimer > block.timestamp, "Presale Ended");
      require(tokenList[_token] != address(0));

      if(!investedList[msg.sender]){
        investedList[msg.sender] = true;
        totalParticipants++;
      }

      uint256 ethAmount = getTokenPrice(tokenList[_token], _amount);
      totalBNBRaised += ethAmount.div(1 ether);
      totalSold += ethAmount.div(getUSDValue());
      require(ethAmount >= 0.01 ether, "Funds Below Minimum Buy");
      balances[msg.sender] = balances[msg.sender].add(ethAmount.div(getUSDValue()));
      IERC20(_token).transferFrom(msg.sender, owner(), _amount);
      //IERC20(rareToken).transfer(msg.sender, ethAmount.div(getUSDValue()) );
      emit purchase(msg.sender, ethAmount.div(getUSDValue()));
    }

    // calculate price based on pair reserves
    function getTokenPrice(address pairAddress, uint amount) public view returns(uint)
    {
     IPancakePair pair = IPancakePair(pairAddress);

     if(pair.token0() != WETH){
       IERC20 token1 = IERC20(pair.token1());
       (uint Res0, uint Res1,) = pair.getReserves();
       // decimals
       uint res1 = Res1*(10**token1.decimals());
       return(res1/Res0*amount); // return amount of token0 needed to buy token1
     }
     else{
       IERC20 token0 = IERC20(pair.token0());
       (uint Res1, uint Res0,) = pair.getReserves();
       // decimals
       uint res1 = Res1*(10**token0.decimals());
       return(res1/Res0*amount); // return amount of token0 needed to buy token1
     }
    }


    // calculate price based on pair reserves
    function getUSDValue() public view returns(uint)
    {
     IPancakePair pair = IPancakePair(usdPair);

     if(pair.token0() != WETH){
       (uint Res0, uint Res1,) = pair.getReserves();
       // decimals
       uint res1 = Res1 * 1 ether;
       return( res1 / Res0 * 21000 ); // return amount of token0 needed to buy token1
     }
     else{
       (uint Res1, uint Res0,) = pair.getReserves();
       uint res1 = Res1 * 1 ether;
       return( res1 / Res0 * 21000 ); // return amount of token0 needed to buy token1
     }
    }

    function withdrawTokens() public {
      require(presaleTimer < block.timestamp, "Presale Not Ended");
      uint256 payout = balances[msg.sender];
      balances[msg.sender] = 0;
      IERC20(rareToken).transfer(msg.sender, payout );
    }

    function withdraw() public onlyOwner{
      IERC20(rareToken).transfer(msg.sender, IERC20(rareToken).balanceOf(address(this)) );
    }


  }
