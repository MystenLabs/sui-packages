module 0x5ec4934335db964818b3ffa999e2c1343daac080bf5963f5b5aeed5bf27e12c4::gateway {
    public entry fun deposit(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun deposit_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

