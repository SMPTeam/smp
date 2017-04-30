pragma solidity ^0.4.4;
import "SurveyResult.sol";

contract SurveyRegister{
    
    mapping(address =>uint)public registrationTime;
		
    mapping(address =>uint[20]) public priceList;
	
    function setCurrentTime(address _address) {
        registrationTime[_address] = now;
    }

    function getCurrentTime(address _address)constant returns(uint){
        return registrationTime[_address];
    }

    //set price for survey
    function setPriceRange_1(address _address, uint _11, uint _12, uint _13, uint _14, uint _15){
        priceList[_address][0] = _11;
        priceList[_address][1] = _12;
        priceList[_address][2] = _13;
        priceList[_address][3] = _14;
        priceList[_address][4] = _15;
    }
    
    function setPriceRange_2(address _address, uint _21,uint _22,uint _23,uint _24,uint _25)  {
        priceList[_address][5] = _21;
        priceList[_address][6] = _22;
        priceList[_address][7] = _23;
        priceList[_address][8] = _24;
        priceList[_address][9] = _25;
    }
    
    function setPriceRange_3(address _address, uint _31, uint _32, uint _33, uint _34, uint _35)  {
        priceList[_address][10] = _31;
        priceList[_address][11] = _32;
        priceList[_address][12] = _33;
        priceList[_address][13] = _34;
        priceList[_address][14] = _35;
    }
    
    function setPriceRange_4(address _address, uint _41, uint _42, uint _43, uint _44, uint _45)  {
        priceList[_address][15] = _41;
        priceList[_address][16] = _42;
        priceList[_address][17] = _43;
        priceList[_address][18] = _44;
        priceList[_address][19] = _45;
    }
    
    function getPriceRange_1(address _address)constant returns(uint _0,uint _1,uint _2,uint _3,uint _4){
        return(
        _0 = priceList[_address][0],
        _1 = priceList[_address][1],
        _2 = priceList[_address][2],
        _3 = priceList[_address][3],
        _4 = priceList[_address][4]
        );
    }
    
    function getPriceRange_2(address _address)constant returns(uint _5,uint _6,uint _7,uint _8,uint _9){
        return(
        _5 = priceList[_address][5],
        _6 = priceList[_address][6],
        _7 = priceList[_address][7],
        _8 = priceList[_address][8],
        _9 = priceList[_address][9]
        );
    }
    function getPriceRange_3(address _address)constant returns(uint _10 ,uint _11 ,uint _12,uint _13,uint _14){
        return(
        _10 = priceList[_address][10],
        _11 = priceList[_address][11],
        _12 = priceList[_address][12],
        _13 = priceList[_address][13],
        _14 = priceList[_address][14]
        );
    }
     
    function getPriceRange_4(address _address)constant returns(uint _15,uint _16,uint _17,uint _18,uint _19){
        return(
        _15 = priceList[_address][15],
        _16 = priceList[_address][16],
        _17 = priceList[_address][17],
        _18 = priceList[_address][18],
        _19 = priceList[_address][19]
        );
    }
    
    function callSetPriceList(address _cAddress, address _address){
        SurveyResult sr = SurveyResult(_cAddress);       
        sr.setPriceList(_address,priceList[_address]);
    }   
} 
