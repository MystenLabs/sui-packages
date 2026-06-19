module 0x3d95e6f1a4ca7d8341c2d7bc054014cf53b099eb4686ca194b5b470d2d38921a::confidential_adapter {
    public fun is_confidential_mode() : bool {
        false
    }

    public fun withdraw_for_payout<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

