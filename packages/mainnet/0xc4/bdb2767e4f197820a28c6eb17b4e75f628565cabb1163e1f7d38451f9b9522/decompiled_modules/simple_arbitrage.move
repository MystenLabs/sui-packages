module 0xc4bdb2767e4f197820a28c6eb17b4e75f628565cabb1163e1f7d38451f9b9522::simple_arbitrage {
    public entry fun execute_atomic_arbitrage(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun get_min_input_amount() : u64 {
        10000000
    }

    // decompiled from Move bytecode v6
}

