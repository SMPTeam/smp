pragma solidity ^0.4.4;
contract Product{

    struct ProductBasic{
        address productAddress;
        string productName;
        string productFileName;
        uint productCategory1;
        uint productCategory2;
        uint productCategory3;
    }

    struct ProductStatus{
        address ownerAddress;
        uint surveyStatus; // 0:not started, 1:open, 2:stop, 3:close, 4:canceled
        uint salesStatus; //0:not started, 1:on sale, 2:selling discontinued
        uint moralStatus; // 0:no problem 1:something wrong on moral
        uint likeStatus; //add "like" when users think and push that button
    }
    
    struct ProductSales{
        uint catalogPrice;
        uint currentPrice;
        uint salseAmount;
        uint sharePoint;
        uint shareLevel;
    }
    
    struct ProductUpdateTime{
        uint surveyRegisterdTime;
        uint listedTime;
        uint lastUpdateTime;
    }
    
    uint public registerNumber;
    mapping(uint => ProductBasic)public productBasic;
    mapping(address => ProductStatus)public productStatus;
    mapping(address => ProductSales)public productSales;
    mapping(address => ProductUpdateTime)public productUpdateTime;
    
    function increaseReginsterNumber(){
        registerNumber +=1 ; 
    }
    

    function setProductBasic(address _pAddress, string _pName, string _pfName,uint _cat1,uint _cat2,uint _cat3){
        productBasic[registerNumber].productAddress = _pAddress;
        productBasic[registerNumber].productName = _pName;
        productBasic[registerNumber].productFileName = _pfName;
        productBasic[registerNumber].productCategory1 = _cat1;
        productBasic[registerNumber].productCategory2 = _cat2;
        productBasic[registerNumber].productCategory3 = _cat3;
        increaseReginsterNumber();
    }
    
    function setProductStatus(address _pAddress, address _oAddress, uint _svStatus,uint _saStatus,uint _mStatus,uint _lStatus){
        productStatus[_pAddress].ownerAddress = _oAddress;
        productStatus[_pAddress].surveyStatus = _svStatus;
        productStatus[_pAddress].salesStatus = _saStatus;
        productStatus[_pAddress].moralStatus = _mStatus;
        productStatus[_pAddress].likeStatus = _lStatus;
    }
    
    function setProductSales(address _pAddress, uint _caPrice, uint _cuPrice, uint _sAmount, uint _sPoint,uint _sLevel){
        productSales[_pAddress].catalogPrice = _caPrice;
        productSales[_pAddress].currentPrice = _cuPrice;
        productSales[_pAddress].salseAmount = _sAmount;
        productSales[_pAddress].sharePoint = _sPoint;
        productSales[_pAddress].shareLevel = _sLevel;
    }
    
    function setProductUpdateTime(address _pAddress, uint _srTime, uint _lTime, uint _luTime){
        productUpdateTime[_pAddress].surveyRegisterdTime = _srTime;
        productUpdateTime[_pAddress].listedTime = _lTime;
        productUpdateTime[_pAddress].lastUpdateTime = _luTime;
    }
    
    function getRegisterNumber()constant returns(uint _rNum){
        return registerNumber;
    }
    
    function getProductBasic(uint _rNumber)constant returns(address _pAddress, string _pName, string _pfName,uint _cat1,uint _cat2,uint _cat3){
        return(
            _pAddress = productBasic[_rNumber].productAddress,
            _pName = productBasic[_rNumber].productName,
            _pfName = productBasic[_rNumber].productFileName,
            _cat1 = productBasic[_rNumber].productCategory1,
            _cat2 = productBasic[_rNumber].productCategory2,
            _cat3 = productBasic[_rNumber].productCategory3
        );
    }

    function getProductStatus(address _pAddress)constant returns(address _pAdd, address _oAddress, uint _svStatus,uint _saStatus,uint _mStatus,uint _lStatus){
        return(
            _pAdd = _pAddress,
            _oAddress = productStatus[_pAddress].ownerAddress,
            _svStatus = productStatus[_pAddress].surveyStatus,
            _saStatus = productStatus[_pAddress].salesStatus,
            _mStatus = productStatus[_pAddress].moralStatus,
            _lStatus = productStatus[_pAddress].likeStatus
        );
    }
    
    function getProductSales(address _pAddress)constant returns(address _pAdd, uint _caPrice, uint _cuPrice, uint _sAmount, uint _sPoint,uint _sLevel){
        return(
            _pAdd = _pAddress,
            _caPrice = productSales[_pAddress].catalogPrice,
            _cuPrice = productSales[_pAddress].currentPrice,
            _sAmount = productSales[_pAddress].salseAmount,
            _sPoint = productSales[_pAddress].sharePoint,
            _sLevel = productSales[_pAddress].shareLevel           
        );
        
    }
    
    function getProductUpdateTime(address _pAddress)constant returns(address _pAdd, uint _srTime, uint _lTime, uint _luTime){
        return(
            _pAdd = _pAddress,
            _srTime = productUpdateTime[_pAddress].surveyRegisterdTime,
            _lTime = productUpdateTime[_pAddress].listedTime,
            _luTime = productUpdateTime[_pAddress].lastUpdateTime
        );
    }
    
}