module 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Sale {
    struct Settlement has drop {
        investor: address,
        tokens: u64,
        currency: vector<u8>,
        payment_ref: vector<u8>,
        kyc_ok: bool,
    }

    public entry fun record_settlement(arg0: &0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::BridgeStubs::Attestor, arg1: &mut 0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Treasury::Treasury, arg2: address, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::BridgeStubs::is_admin(arg0, 0x2::tx_context::sender(arg7)), 9001);
        assert!(arg6, 9002);
        0xabced4792e1ad37bb1d4bfbe36dcd391b3ed8778b4e91dd9d0cf9192e58bbd4a::Treasury::distribute(arg1, arg2, arg3, arg7);
    }

    // decompiled from Move bytecode v6
}

