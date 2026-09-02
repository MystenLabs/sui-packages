module 0xf18afca53232949c4ead807d34c28ff158bb61ac8200e1e794f3f9fb52800a8c::gateway {
    public entry fun deposit(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun deposit_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

