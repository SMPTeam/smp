pragma solidity ^0.4.4;
contract SurveyResult{
    mapping(address => uint[20]) priceList;
    mapping(address => uint) lrpNumber;
    mapping(address => uint) ppNumber;
    mapping(address => uint) npNumber;
    mapping(address => uint) hrpNumber;
    
    mapping (address => uint) theLrp;
    mapping (address => uint) thePp;
    mapping (address => uint) theNp;
    mapping (address => uint) theHrp;
    
    function setPriceList(address _address,uint[20] _input){
        priceList[_address] = _input;
    }

    function setPriceNumber(address _address,uint _lrp, uint _pp,uint _np,uint _hrp){
        lrpNumber[_address] = _lrp;
        ppNumber[_address] = _pp;
        npNumber[_address] = _np;
        hrpNumber[_address] = _hrp;
    }  

    function setPrice(address _address)(){
        uint lrp;
        uint pp;
        uint np;
        uint hrp;
        string memory ret;
        
        for(uint i = 0 ;i < 20; i++){
            if (lrpNumber[_address] == i) lrp = priceList[_address][i]; 
            if (ppNumber[_address] == i) pp = priceList[_address][i];
            if (npNumber[_address] == i) np = priceList[_address][i];
            if (hrpNumber[_address] == i) hrp = priceList[_address][i];
        }
        
        theLrp[_address] = lrp;
        thePp[_address] = pp;
        theNp[_address] = np;
        theHrp[_address] = hrp;
        
    }  
    
    function getPrice(address _address)constant returns(uint _lrp,uint _pp,uint _np, uint _hrp){
        return(
            _lrp = theLrp[_address],
            _pp = thePp[_address],
            _np = theNp[_address],
            _hrp = theHrp[_address]
        );
    }
        
}