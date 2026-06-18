module 0xa56164186ff51013957c7c886d50eccfea0f75161fc729c4977f2670c360c0b4::confidential_adapter {
    public fun withdraw_for_payout<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

