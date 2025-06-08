module 0x203bbd21feeaa6ea6ea756e83548de6a54ed6ac6c29e5dbbfdfe026d5b44858d::scripts {
    public entry fun create_tournament(arg0: &mut 0x203bbd21feeaa6ea6ea756e83548de6a54ed6ac6c29e5dbbfdfe026d5b44858d::tournament::TournamentRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x203bbd21feeaa6ea6ea756e83548de6a54ed6ac6c29e5dbbfdfe026d5b44858d::tournament::create_tournament(arg0, 0x1::string::utf8(arg1), 0x1::string::utf8(arg2), arg3, arg4, arg5, arg6, arg7, 0x1::vector::empty<0x1::string::String>(), false, false, arg8);
    }

    // decompiled from Move bytecode v6
}

