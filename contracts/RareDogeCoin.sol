pragma solidity ^0.8.0;

import './IERC20.sol';

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract RareDogeCoin {

    using SafeMath for uint256;

    address payable public _owner;
    address payable public _dev;
    address payable public _dev1;
    address public _boosterToken;

    event LogRebase(uint256 indexed epoch, uint256 totalSupply);

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    modifier onlyDev() {
        require(_dev == msg.sender, "Ownable: caller is not the dev");
        _;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    string public constant name = "Rare Dogecoin";
    string public constant symbol = "RD";
    uint256 public constant decimals = 18;

    uint256 private constant MAX_UINT256 = ~uint256(0) / 1000000000000000000;
    uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 3000 * 10**decimals;

    uint256 private constant TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);
    uint256 totalGons = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

    uint256 private _totalSupply;
    uint256 private _gonsPerFragment;
    mapping(address => uint256) private _gonBalances;

    uint256 public currentAth;
    uint256 public epochPrice;
    uint256 public cycleCount;

    address[] public whitelist;

    struct StakeData{
      uint256 stakeTime;
      uint256 amount;
      uint256 claimed;
      uint256 lastUpdate;
      uint256 collected;
      uint256 bonusRate;
    }

    uint256 constant public BONUS_FEE = 0.05 ether;

    mapping(address => mapping(uint256 => StakeData)) public stakes;
    mapping(address => uint256) public stakeNumber;

    mapping(address => uint256) public refCode;
    mapping(uint256 => address) public refCodeIndex;
    mapping(address => address) public myRef;
    uint256 public refCount = 50000000;

    mapping (address => mapping (address => uint256)) private _allowedFragments;

    constructor(address payable owner, address payable dev, address payable dev1, address boosterToken) public {
        require(owner != address(0), "Invalid Owner");
        require(dev != address(0), "Invalid Dev");
        require(dev1 != address(0), "Invalid Dev 1");
        require(boosterToken != address(0), "Invalid Booster");
        _owner = owner;
        _dev = dev;
        _dev1 = dev1;
        _boosterToken = boosterToken;

        _totalSupply = INITIAL_FRAGMENTS_SUPPLY;
        _gonBalances[msg.sender] = TOTAL_GONS;
        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);
        cycleCount = block.timestamp / 86400;

        whitelist.push(owner);

        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function addToWhitelist(address user) external onlyOwner{
      whitelist.push(user);
    }

    function _rebase() internal {
        _totalSupply = _totalSupply.sub(_totalSupply.div(100));
        _gonsPerFragment = totalGons.div(_totalSupply);
        for(uint256 x = 0; x < whitelist.length; x++){
          _gonBalances[whitelist[x]] = _gonBalances[whitelist[x]].add(_gonBalances[whitelist[x]].div(100));
        }
        epochPrice = 0;
        cycleCount = block.timestamp / 86400;
        emit LogRebase(cycleCount, _totalSupply);
    }

    function checkATH(uint256 curPrice) external onlyDev {
      if(curPrice > epochPrice){
        epochPrice = curPrice;
      }

      if(cycleCount != block.timestamp / 86400){
        if(epochPrice > currentAth){
          _rebase();
          currentAth = epochPrice;
        }
        else{
          currentAth = currentAth.mul(99).div(100);
        }
        cycleCount = block.timestamp / 86400;
      }
    }

    function totalSupply()
        external
        view
        returns (uint256)
    {
        return _totalSupply;
    }

    function balanceOf(address who)
        external
        view
        returns (uint256)
    {
        return _gonBalances[who].div(_gonsPerFragment);
    }

    function transfer(address to, uint256 value)
        external
        returns (bool)
    {
        uint256 gonValue = value.mul(_gonsPerFragment);
        _gonBalances[msg.sender] = _gonBalances[msg.sender].sub(gonValue);
        _gonBalances[to] = _gonBalances[to].add(gonValue);
        emit Transfer(msg.sender, to, value);

        return true;
    }

    function allowance(address owner_, address spender)
        external
        view
        returns (uint256)
    {
        return _allowedFragments[owner_][spender];
    }

    function transferFrom(address from, address to, uint256 value)
        external
        returns (bool)
    {
        if(msg.sender != address(this)){
          _allowedFragments[from][msg.sender] = _allowedFragments[from][msg.sender].sub(value);
        }

        uint256 gonValue = value.mul(_gonsPerFragment);
        _gonBalances[from] = _gonBalances[from].sub(gonValue);
        _gonBalances[to] = _gonBalances[to].add(gonValue);
        emit Transfer(from, to, value);

        return true;
    }

    function approve(address spender, uint256 value)
        external
        returns (bool)
    {
        _allowedFragments[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        external
        returns (bool)
    {
        _allowedFragments[msg.sender][spender] =
            _allowedFragments[msg.sender][spender].add(addedValue);
        emit Approval(msg.sender, spender, _allowedFragments[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        external
        returns (bool)
    {
        uint256 oldValue = _allowedFragments[msg.sender][spender];
        if (subtractedValue >= oldValue) {
            _allowedFragments[msg.sender][spender] = 0;
        } else {
            _allowedFragments[msg.sender][spender] = oldValue.sub(subtractedValue);
        }
        emit Approval(msg.sender, spender, _allowedFragments[msg.sender][spender]);
        return true;
    }

    function _mint(address _user, uint256 _amount) internal{
      _gonBalances[_user] = _gonBalances[_user].add(_amount.mul(_gonsPerFragment));
      totalGons = totalGons.add(_amount.mul(_gonsPerFragment));
      _totalSupply = _totalSupply.add(_amount);
      _gonsPerFragment = totalGons.div(_totalSupply);
    }

    function _burn(address _user, uint256 _amount) internal{
      uint256 gonValue = _amount.mul(_gonsPerFragment);
      _gonBalances[_user] = _gonBalances[_user].sub(gonValue);
      _totalSupply = _totalSupply.sub(_amount);
      _gonsPerFragment = totalGons.div(_totalSupply);
    }

    function createRefCode() external returns (uint256){
      require(refCode[msg.sender] == 0);
      refCode[msg.sender] = refCount;
      refCodeIndex[refCount] = msg.sender;
      refCount++;
      return refCode[msg.sender];
    }

    function stake(uint256 _amount, uint256 _referer) external {
      require(_amount >= 0.0001 ether, "Amount Too Low");
      stakes[msg.sender][stakeNumber[msg.sender]].amount = _amount;
      stakes[msg.sender][stakeNumber[msg.sender]].stakeTime = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].lastUpdate = block.timestamp;
      stakeNumber[msg.sender]++;

      _burn(msg.sender, _amount.mul(4).div(5));

      if(refCodeIndex[_referer] != address(0) || myRef[msg.sender] != address(0)){
        if(myRef[msg.sender] == address(0)){
          myRef[msg.sender] = refCodeIndex[_referer];
        }
        this.transferFrom(msg.sender, _dev, _amount.mul(4).div(100));
        this.transferFrom(msg.sender, _dev1, _amount.mul(1).div(100));
        this.transferFrom(msg.sender, _owner, _amount.mul(8).div(100));
        this.transferFrom(msg.sender, myRef[msg.sender], _amount.mul(7).div(100));
      }
      else{
        this.transferFrom(msg.sender, _dev, _amount.mul(4).div(100));
        this.transferFrom(msg.sender, _dev1, _amount.mul(1).div(100));
        this.transferFrom(msg.sender, _owner, _amount.mul(15).div(100));
      }

    }

    function calcReward(address _user, uint256 _stakeIndex) public view returns(uint256) {
      if(stakes[_user][_stakeIndex].stakeTime == 0){
        return 0;
      }
      uint256 multiplier = (block.timestamp - stakes[_user][_stakeIndex].lastUpdate).mul(11574074074074);
      multiplier = multiplier.add(multiplier.mul(stakes[_user][_stakeIndex].bonusRate));
      if(stakes[_user][_stakeIndex].amount.mul(multiplier).div(1000 ether).add(stakes[msg.sender][_stakeIndex].collected) > stakes[_user][_stakeIndex].amount.mul(150).div(100)){
        return(stakes[_user][_stakeIndex].amount.mul(150).div(100).sub(stakes[msg.sender][_stakeIndex].collected));
      }
      return stakes[_user][_stakeIndex].amount.mul(multiplier).div(1000 ether);
    }

    function calcClaim(address _user, uint256 _stakeIndex) external view returns(uint256) {
      if(stakes[_user][_stakeIndex].stakeTime == 0){
        return 0;
      }
      uint256 multiplier = (block.timestamp - stakes[_user][_stakeIndex].lastUpdate).mul(11574074074074);
      multiplier = multiplier.add(multiplier.mul(stakes[_user][_stakeIndex].bonusRate));

      if(multiplier.mul(stakes[_user][_stakeIndex].amount).div(1000 ether).add(stakes[msg.sender][_stakeIndex].collected) > stakes[_user][_stakeIndex].amount.mul(150).div(100)){
        return(stakes[_user][_stakeIndex].amount.mul(150).div(100).sub(stakes[msg.sender][_stakeIndex].claimed));
      }
      return multiplier.mul(stakes[_user][_stakeIndex].amount).div(1000 ether).add(stakes[msg.sender][_stakeIndex].collected).sub(stakes[msg.sender][_stakeIndex].claimed);
    }

    function _collect(address _user, uint256 _stakeIndex) internal {
      stakes[_user][_stakeIndex].collected = stakes[_user][_stakeIndex].collected.add(calcReward(_user, _stakeIndex));
      stakes[_user][_stakeIndex].lastUpdate = block.timestamp;
    }

    function claim(uint256 _stakeIndex) external {
      _collect(msg.sender, _stakeIndex);
      uint256 reward = stakes[msg.sender][_stakeIndex].collected.sub(stakes[msg.sender][_stakeIndex].claimed);
      stakes[msg.sender][_stakeIndex].claimed = stakes[msg.sender][_stakeIndex].collected;
      _mint(msg.sender, reward);
    }

    function increaseRate(uint256 _amount, uint256 _stakeIndex) external payable {
      require(stakes[msg.sender][_stakeIndex].stakeTime != 0, "Stake Not Active");
      require(msg.value >= _amount.mul(BONUS_FEE), "Insufficient Funds Sent");
      require(stakes[msg.sender][_stakeIndex].bonusRate + _amount < 20, "Amount Exceeds Max Rate");
      _collect(msg.sender, _stakeIndex);
      stakes[msg.sender][_stakeIndex].bonusRate = stakes[msg.sender][_stakeIndex].bonusRate.add(_amount);
      _owner.transfer(msg.value);
    }

    function useBooster(uint256 _stakeIndex) external {
      require(stakes[msg.sender][_stakeIndex].bonusRate != 49, "Booster Used Already");
      _collect(msg.sender, _stakeIndex);
      stakes[msg.sender][_stakeIndex].bonusRate = 49;
      IERC20(_boosterToken).transferFrom(msg.sender, address(this), 1 ether);
      IERC20(_boosterToken).burn(1 ether);
    }

    function reinvest(uint256 _stakeIndex) external {
      _collect(msg.sender, _stakeIndex);
      uint256 _amount = stakes[msg.sender][_stakeIndex].collected.sub(stakes[msg.sender][_stakeIndex].claimed);
      require(_amount > 0.0001 ether, "Stake Too Low");
      stakes[msg.sender][stakeNumber[msg.sender]].amount = _amount;
      stakes[msg.sender][_stakeIndex].claimed = stakes[msg.sender][_stakeIndex].collected;
      stakes[msg.sender][stakeNumber[msg.sender]].stakeTime = block.timestamp;
      stakes[msg.sender][stakeNumber[msg.sender]].lastUpdate = block.timestamp;
      stakeNumber[msg.sender]++;
      if(myRef[msg.sender] != address(0)){
        _mint(_dev, _amount.mul(4).div(100));
        _mint(_dev1, _amount.mul(1).div(100));
        _mint(_owner, _amount.mul(8).div(100));
        _mint(myRef[msg.sender], _amount.mul(7).div(100));
      }
      else{
        _mint(_dev, _amount.mul(4).div(100));
        _mint(_dev1, _amount.mul(1).div(100));
        _mint(_owner, _amount.mul(15).div(100));
      }

    }

}

