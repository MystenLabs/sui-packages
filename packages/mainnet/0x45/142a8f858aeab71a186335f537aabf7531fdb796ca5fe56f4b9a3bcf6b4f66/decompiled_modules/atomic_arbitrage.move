module 0x45142a8f858aeab71a186335f537aabf7531fdb796ca5fe56f4b9a3bcf6b4f66::atomic_arbitrage {
    public entry fun basic_sui_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun module_loaded() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

