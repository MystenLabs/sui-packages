module 0x7405defa4efd99ede54fc010b3368728bbbeca83e443a25dbfa2aa8ac47bea4::hedge {
    public entry fun close_hedge_and_take_profit(arg0: &0xf94b9c4628a3bf7cd3b530641f0aaf2904ad8d6fe18a864dfad061825cf89f5d::vault::OperatorCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun supply_and_hedge<T0>(arg0: &0xf94b9c4628a3bf7cd3b530641f0aaf2904ad8d6fe18a864dfad061825cf89f5d::vault::OperatorCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

