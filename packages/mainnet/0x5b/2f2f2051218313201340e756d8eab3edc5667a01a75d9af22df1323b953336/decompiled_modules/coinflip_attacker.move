module 0x5b2f2f2051218313201340e756d8eab3edc5667a01a75d9af22df1323b953336::coinflip_attacker {
    public entry fun attack(arg0: &mut 0x5b2f2f2051218313201340e756d8eab3edc5667a01a75d9af22df1323b953336::flash_pool::FlashPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    // decompiled from Move bytecode v6
}

