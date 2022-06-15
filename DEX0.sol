pragma solidity ^0.8;

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}

contract DEX0{
    IERC20 public tokenA;
    IERC20 public tokenB;
    constructor(address _tokenA,address _tokenB){
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }
    //只接受A或B
    //如果输入A我们给他B 如果B给A
    function swap(address tokenIn,uint amountIn) external{
        require(tokenIn == address(tokenA) || tokenIn == address(tokenB),"valid token or address");
        if(tokenIn == address(tokenA)){
            tokenA.transferFrom(msg.sender,address(this),amountIn);
            tokenB.transfer(msg.sender,amountIn);
        }else{
            tokenB.transferFrom(msg.sender,address(this),amountIn);
            tokenA.transfer(msg.sender,amountIn);            
        }
    }
}
