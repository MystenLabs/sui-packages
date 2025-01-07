module 0x34aea359a8c5ce8944a5f27c0566d88c9e800d5d5d2c5d11d2e2be777eaa8c44::kriya_swap {
    public fun swap_by_a_in<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        if (arg2 == 0) {
            arg2 = 0x2::coin::value<T0>(&arg1);
        };
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, arg1, arg2, 0, arg3);
        (0x2::coin::value<T1>(&v0), v0)
    }

    public fun swap_by_b_in<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        if (arg2 == 0) {
            arg2 = 0x2::coin::value<T1>(&arg1);
        };
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, arg1, arg2, 0, arg3);
        (0x2::coin::value<T0>(&v0), v0)
    }

    // decompiled from Move bytecode v6
}

