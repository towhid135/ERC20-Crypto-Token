pragma solidity ^0.4.24;


/**
ERC Token Standard #20 Interface
*/

/*this is an abstract contract, where we only declare the function and implement on the other contract*/
contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    //function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract myToken is ERC20Interface{
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;
    address public contractDeployersAccount;
    using SafeMath for uint;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;


    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------
    constructor() public {
        symbol = "$Gaze$";
        name = "Gtoken";
        decimals = 2;
        _totalSupply = 60000;
        contractDeployersAccount = 0xE148770B989548881a02d56ECe4cCdDDb7238813;
        //balances[contractDeployersAccount] = _totalSupply;
        //emit Transfer(address(0),contractDeployersAccount, _totalSupply);
        balances[contractDeployersAccount] = _totalSupply;
        emit Transfer(address(0),contractDeployersAccount, _totalSupply);
    }


    // ------------------------------------------------------------------------
    // Total supply
    // ------------------------------------------------------------------------
    function totalSupply() public constant returns (uint) {
        return _totalSupply.sub(balances[address(0)]);
    }
    
    //this function is only for the main deployer of the contract
    function burnToken(uint tokens) public {
        require(msg.sender == contractDeployersAccount);
        require(balances[msg.sender] >= tokens,"Amount of burn tokens should be less than or equal to your balance");
        balances[msg.sender] = balances[msg.sender].sub(tokens);
    }


    // ------------------------------------------------------------------------
    // Get the token balance for account tokenOwner
    // ------------------------------------------------------------------------
    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }


    // ------------------------------------------------------------------------
    // Transfer the balance from token owner's account to to account
    // - Owner's account must have sufficient balance to transfer
    // - 0 value transfers are allowed
    // ------------------------------------------------------------------------
    function transfer(address to, uint tokens) public returns (bool success) {
        
        //require(allowed[msg.sender][msg.sender] >= tokens);
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        allowed[msg.sender][msg.sender] = allowed[msg.sender][msg.sender].sub(tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Token owner can approve for spender to transferFrom(...) tokens
    // from the token owner's account
    //
    // https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
    // recommends that there are no checks for the approval double-spend attack
    // as this should be implemented in user interfaces 
    // ------------------------------------------------------------------------
    function approve(address spender, uint tokens) public returns (bool success) {
        /* Here msg.sender is the person who is willing to spend some token, but first
        he needs his own permission that means he is agreed to spend */
       //require(msg.sender == spender);
        //require(balances[msg.sender] >= tokens);
        
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Returns the amount of tokens approved by the owner that can be
    // transferred to the spender's account
    // ------------------------------------------------------------------------
    //currently how many tokens are allowed for him to transfer
    function allowance(address tokenOwner) public constant returns (uint remaining) {
        return allowed[msg.sender][tokenOwner];
    }


    // ------------------------------------------------------------------------
    // Don't accept ETH
    // ------------------------------------------------------------------------
    function () public payable {
        revert();
    }
}

library SafeMath{
        function sub(uint256 a, uint256 b) internal pure returns(uint256){
            assert(b <= a);
            return a - b;
        }
        
        function add(uint256 a, uint256 b) internal pure returns(uint256){
            uint256 c = a + b;
            assert(c >= a);
            return c;
        }
    }
