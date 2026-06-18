module 0x3ae89583ac55a94d08d1519e17557f733e0b474e40ca603b350e5c85c7943da4::confidential_adapter {
    public fun withdraw_for_payout<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

