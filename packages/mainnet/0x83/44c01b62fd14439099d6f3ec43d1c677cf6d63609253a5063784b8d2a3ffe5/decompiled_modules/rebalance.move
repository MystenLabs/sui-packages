module 0x8344c01b62fd14439099d6f3ec43d1c677cf6d63609253a5063784b8d2a3ffe5::rebalance {
    public entry fun add_liquidity(arg0: &0xf94b9c4628a3bf7cd3b530641f0aaf2904ad8d6fe18a864dfad061825cf89f5d::vault::OperatorCap, arg1: address, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun close_position(arg0: &0xf94b9c4628a3bf7cd3b530641f0aaf2904ad8d6fe18a864dfad061825cf89f5d::vault::OperatorCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun swap_to_usdsui<T0, T1>(arg0: &0xf94b9c4628a3bf7cd3b530641f0aaf2904ad8d6fe18a864dfad061825cf89f5d::vault::OperatorCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

