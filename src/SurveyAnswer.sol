pragma solidity ^0.4.4;

import "SurveyResult.sol";
    
contract SurveyAnswer{
    
    mapping (address => uint[1000]) votedPriceNumber_TooCheap;
    mapping (address => uint[1000]) votedPriceNumber_Cheap;
    mapping (address => uint[1000]) votedPriceNumber_Expensive;
    mapping (address => uint[1000]) votedPriceNumber_TooExpensive;
    mapping (address => uint[20]) count_TooCheap;
    mapping (address => uint[20]) count_Cheap;
    mapping (address => uint[20]) count_Expensive;
    mapping (address => uint[20]) count_TooExpensive;
    mapping (address => uint) votedCount ;
    mapping (address => address[1000]) votedUsers ;
    
    uint lrpNumber ;
    uint ppNumber ;
    uint npNumber ;
    uint hrpNumber ;
    mapping (address => uint) public theLrpNumber;
    mapping (address => uint) public thePpNumber;
    mapping (address => uint) public theNpNumber;
    mapping (address => uint) public theHrpNumber;

    function increaseVotedCount(address _address){
        votedCount[_address] += 1;
    }
    
    function returnVoutedCount(address _address)constant returns(uint ret){
        return votedCount[_address];
    }

    function answer(address _address, uint _tc, uint _c, uint _e , uint _te,address _userID){
        uint countNumber = votedCount[_address] ;
        votedPriceNumber_TooCheap[_address][countNumber] = _tc;
        votedPriceNumber_Cheap[_address][countNumber] = _c;
        votedPriceNumber_Expensive[_address][countNumber] = _e;
        votedPriceNumber_TooExpensive[_address][countNumber] = _te;
        increaseVotedCount(_address);
        votedUsers[_address][countNumber]= _userID;
    }
    
    function getAnswer(address _address, uint _num)constant returns( uint _tc, uint _c, uint _e , uint _te,address _userID){
        return(
            votedPriceNumber_TooCheap[_address][_num],
            votedPriceNumber_Cheap[_address][_num],
            votedPriceNumber_Expensive[_address][_num],
            votedPriceNumber_TooExpensive[_address][_num],
            votedUsers[_address][_num]
        );
    }

    function countTooCheap(address _address){
       //initialize
        for (uint a = 0; a < 20; a ++){
            count_TooCheap[_address][a] = 0;
        }
        //Count
        for (uint i = 0; i < votedCount[_address]; i++){
            for( uint ii = 0; ii < 20; ii++ ){
                if (votedPriceNumber_TooCheap[_address][i] == ii)
                    count_TooCheap[_address][ii] +=1;
            }
        }
    }

    function countCheap(address _address){
        //initialize
        for (uint a = 0; a < 20; a ++){
            count_Cheap[_address][a] = 0;
        }
        //Count
        for (uint j = 0; j < votedCount[_address]; j++){
            for( uint jj = 0; jj < 20; jj++ ){
                if (votedPriceNumber_Cheap[_address][j] == jj)
                    count_Cheap[_address][jj] +=1;
            }
        }
    }

    function countExpensive(address _address){
        //initialize
        for (uint a = 0; a < 20; a ++){
            count_Expensive[_address][a] = 0;
        }
        //Count
        for (uint k = 0; k < votedCount[_address]; k++){
            for( uint kk = 0; kk < 20; kk++ ){
                if (votedPriceNumber_Expensive[_address][k] == kk)
                    count_Expensive[_address][kk] +=1;
            }
        }
    }
 
    function countTooExpensive(address _address){
        //initialize
        for (uint a = 0; a < 20; a ++){
            count_TooExpensive[_address][a] = 0;
        }
        //Count
        for (uint l = 0; l < votedCount[_address]; l++){
            for( uint ll = 0; ll < 20; ll++ ){
                if (votedPriceNumber_TooExpensive[_address][l] == ll)
                    count_TooExpensive[_address][ll] +=1;
            }
        }
    } 

    function calculateLRP(address _address){
        uint[20] memory countTooCheap;
        uint[20] memory countExpensive;
        uint[20] memory lrpArray;
        uint lrp;
        
        countTooCheap = count_TooCheap[_address];
        countExpensive = count_Expensive[_address];
        
        //calculation for Too Cheap Curve
        for(uint i = 18; i > 0; i--){
            countTooCheap[i] =  countTooCheap[i] + countTooCheap[i +1]; 
        }
        countTooCheap[0] = countTooCheap[0] + countTooCheap[1];
        
	//calculation for Expensive Curve
        for(uint j = 1; j < 20; j++){
           countExpensive[j] =  countExpensive[j] + countExpensive[j -1]; 
        }
        
        lrpNumber = 0;
        lrp =  (countTooCheap[0] - countExpensive[0]) **2;
        for(uint k=1; k<20; k ++){
            lrpArray[k] = (countTooCheap[k] - countExpensive[k]) **2;
            if(lrp > lrpArray[k]) lrpNumber = k;
            if(lrp > lrpArray[k]) lrp = lrpArray[k];
        }
        
        theLrpNumber[_address] = lrpNumber;
        
    }        
   
     function calculatePP(address _address){
        uint[20] memory countTooCheap;
        uint[20] memory countTooExpensive;
        uint[20] memory ppArray;
        uint pp;
        
        countTooCheap =  count_TooCheap[_address];
        countTooExpensive = count_TooExpensive[_address];
        
        //calculation for Too Cheap Curve
        for(uint i = 18; i > 0; i--){
           countTooCheap[i] =  countTooCheap[i] + countTooCheap[i +1]; 
        }
        countTooCheap[0] = countTooCheap[0] + countTooCheap[1];
        
        //calculation for TooExpensive Curve
        for(uint j = 1; j < 20; j++){
           countTooExpensive[j] =  countTooExpensive[j] + countTooExpensive[j -1]; 
        }
        
        ppNumber = 0;
        pp =  (countTooCheap[0] - countTooExpensive[0]) **2;
        for(uint k=1; k<20; k ++){
            ppArray[k] = (countTooCheap[k] -  countTooExpensive[k]) **2;
            if(pp > ppArray[k]) ppNumber = k;
            if(pp > ppArray[k]) pp = ppArray[k];
        }
        
        thePpNumber[_address] = ppNumber;
    }

    function calculateNP(address _address){
        uint[20] memory countCheap;
        uint[20] memory countExpensive;
        uint[20] memory npArray;
        uint np;
        
        countCheap = count_Cheap[_address];
        countExpensive = count_Expensive[_address];
       
         //calculation for Cheap Curve
        for(uint i = 18; i > 0; i--){
           countCheap[i] =  countCheap[i] + countCheap[i +1]; 
        }
        countCheap[0] = countCheap[0] + countCheap[1];
        
        //calculation for Expensive Curve
        for(uint j = 1; j < 20; j++){
           countExpensive[j] =  countExpensive[j] + countExpensive[j -1]; 
        }
        
        npNumber =19;
        np =  (countExpensive[19] - countCheap[19]) **2;
        for(uint k= 18 ; k > 0; k--){
            npArray[k] = (countExpensive[k] - countCheap[k]) **2;
            if(np > npArray[k]) npNumber = k;
            if(np > npArray[k]) np = npArray[k];
        }
        theNpNumber[_address] = npNumber;
    }
    
    function calculateHRP(address _address){
        uint[20] memory countCheap;
        uint[20] memory countTooExpensive;
        uint[20] memory hrpArray;
        uint hrp;
       
        countCheap =  count_Cheap[_address];
        countTooExpensive =  count_TooExpensive[_address];
       
        //calculation for Cheap Curve
        for(uint i = 18; i > 0; i--){
           countCheap[i] =  countCheap[i] + countCheap[i +1];
        }
        countCheap[0] = countCheap[0] + countCheap[1];
        
        //calculation for TooExpensive Curve
        for(uint j = 1; j < 20; j++){
           countTooExpensive[j] =  countTooExpensive[j] + countTooExpensive[j -1]; 
        }
        
        hrpNumber =19; 
        hrp =  (countTooExpensive[19] - countCheap[19]) **2;
        for(uint k = 18; k > 0; k--){
            hrpArray[k] = (countTooExpensive[k] - countCheap[k]) **2;
		    if(hrp > hrpArray[k]) hrpNumber = k;
		    if(hrp > hrpArray[k]) hrp = hrpArray[k];
        }
        theHrpNumber[_address] = hrpNumber;
    }
    
    function callSetPriceNumber(address _cAddress, address _address){
        SurveyResult sr = SurveyResult(_cAddress);
        sr.setPriceNumber(_address,theLrpNumber[_address],thePpNumber[_address],theNpNumber[_address],theHrpNumber[_address]);
    }

}
