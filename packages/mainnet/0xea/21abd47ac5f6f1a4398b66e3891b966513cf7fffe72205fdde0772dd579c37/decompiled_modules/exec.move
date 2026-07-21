module 0xea21abd47ac5f6f1a4398b66e3891b966513cf7fffe72205fdde0772dd579c37::exec {
    public entry fun triangle<T0, T1, T2>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T2>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, arg3, arg4, 0, arg5);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T2>(arg1, v0, 0x2::coin::value<T0>(&v0), 0, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T2, T1>(arg2, v1, 0x2::coin::value<T2>(&v1), 0, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

