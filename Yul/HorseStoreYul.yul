object "HorseStoreYul" {
    code {
        // Contract Deployment 
        datacopy(0, dataoffset("runtime"), datasize("runtime")) 
        return(0, datasize("runtime")) // it is yul specific 
    } 
    object "runtime" {
        code {}
        // function dispatcher 
        switch selector() 
        // updateHorseNumber(uint256) 
        case 0xcdfead2e {

        }
        // readNumberHourses 
        case 0xe026c017 {

        }
        defualt {
            revert(0,0) 
            
        }
    } 


}