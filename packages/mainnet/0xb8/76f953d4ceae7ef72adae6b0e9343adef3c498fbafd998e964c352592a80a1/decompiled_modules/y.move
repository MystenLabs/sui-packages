module 0xb876f953d4ceae7ef72adae6b0e9343adef3c498fbafd998e964c352592a80a1::y {
    public fun ab<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg2);
        0x2::coin::into_balance<T1>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), 0x2::balance::value<T0>(&arg1), 0, arg2))
    }

    public fun ba<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg2);
        0x2::coin::into_balance<T0>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg2), 0x2::balance::value<T1>(&arg1), 0, arg2))
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, 0x2::sui::SUI>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg2);
        0x2::coin::into_balance<T0>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, 0x2::sui::SUI>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg2), 0x2::balance::value<0x2::sui::SUI>(&arg1), 0, arg2))
    }

    public fun xs<T0>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, 0x2::sui::SUI>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg2);
        0x2::coin::into_balance<0x2::sui::SUI>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, 0x2::sui::SUI>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), 0x2::balance::value<T0>(&arg1), 0, arg2))
    }

    // decompiled from Move bytecode v7
}

