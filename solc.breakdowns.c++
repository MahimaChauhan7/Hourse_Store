// Solc bytecode represented as a string to avoid an oversized integer literal
static const char solc_breakdowns_hex[] = "0x608060405234801561000f575f80fd5b506101438061001d5f395ff3fe608060405234801561000f575f80fd5b5060043610610034575f3560e01c8063cdfead2e14610038578063e026c01714610054575b5f80fd5b610052600480360381019061004d91906100ba565b610072565b005b61005c61007b565b60405161006991906100f4565b60405180910390f35b805f8190555050565b5f8054905090565b5f80fd5b5f819050919050565b61009981610087565b81146100a3575f80fd5b50565b5f813590506100b481610090565b92915050565b5f602082840312156100cf576100ce610083565b5b5f6100dc848285016100a6565b91505092915050565b6100ee81610087565b82525050565b5f6020820190506101075f8301846100e5565b9291505056fea2646970667358221220dbb8448fdca8c155c26e1ec380b5e8ac2608a10fd031ba5338fc91ab46b023e964736f6c63430008140033";
// 3 Sections:
// 1. Contract Creation
// 2. Runtime
// 3. Metadata

// We need both a stack and memory in the EVM.
// Stack is restircted in size, memory is much bigger
// Variables are returned from memory, not stack
// We reserve the 0x00 slot of memory for the hashing stuff.
// At location 0x40 in memory is "special" for solidity. It's the free memeory pointer.
PUSH1 0X80                          //[0X80]
    PUSH 0X40                       // [0X40, 0X80]
    MSTORE                          //[] // MEMORY 0X40 -> 0X80
                                    // wHAT'S THIS CHUNK DO?
                                    // If someon sent vaule with this call revert!
                                    // Otherwise, jump, to continue exectution
        CALLVALUE                   //[MSG.VALUE]
            DUP1                    // [msg.value, msg.value]
                ISZERO              // [msg.value ==0, msg.value]
                    PUSH1 0X0e      // [0x0E, msg.value]
    JUMPI                           //[msg.value]
        PUSH0                       //[0x00, msg.value]
            REVERT                  // [msg.value]
                CODECOPY            // [0xa5] Memory:[runtime code ]
                    PUSH0           // [0X00, 0Xa5]
                        RETURN      //[]
                            INVALID //[]
                                    // having constructor is more gas effiecent

                                PUSH0              //[0]
                                    CALLDATALOAD   //[32 bytes of calldata]
                                        PUSH1 0xe0 //[0xe0, 32 bytes of calldata]
    SHR                                            // [CALLDATA[0:4]]  // function_Selector
        DUP1                                       //[func_selector, func_selector]
            EQ                                     // [func_selector == 0xcdfead2e, func_selector]
                PUSH1 0x34                         //[0x34, func_selector == 0xcdfead2e, func_selector]
    JUMPI                                          // [func_selector].
                                                   // if func_selector == 0xcdfead2e -> set_number_of_horses
        DUP1                                       // [func_selector, func_selector]
            PUSH4 0xe026c017                       //[0xe026c017, func_selector, func_selector]
    JUMPI                                          // [func_selector]
    // if func_selector == 0xe026017 --> get_number_of_horses.
    // We are going to jump to jump dest 3 if there is more calldata than:
    // function selector + 0x20
    // Revert if there isn't enought calldata!       
    
