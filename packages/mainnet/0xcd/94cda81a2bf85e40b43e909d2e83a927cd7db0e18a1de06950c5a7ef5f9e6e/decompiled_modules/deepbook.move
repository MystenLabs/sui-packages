module 0xcd94cda81a2bf85e40b43e909d2e83a927cd7db0e18a1de06950c5a7ef5f9e6e::deepbook {
    public fun deepbook_base_for_quote<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T0>(&arg3), arg3, 0x2::coin::zero<T1>(arg6), arg4, arg6);
        0xcd94cda81a2bf85e40b43e909d2e83a927cd7db0e18a1de06950c5a7ef5f9e6e::utils::destroy_or_transfer<T0>(0x2::coin::split<T0>(&mut arg3, 0x2::coin::value<T0>(&arg3) % arg5, arg6), arg6);
        0xcd94cda81a2bf85e40b43e909d2e83a927cd7db0e18a1de06950c5a7ef5f9e6e::utils::destroy_or_transfer<T0>(v0, arg6);
        v1
    }

    public fun deepbook_quote_for_base<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T1>(&arg4), arg3, arg4, arg6);
        0xcd94cda81a2bf85e40b43e909d2e83a927cd7db0e18a1de06950c5a7ef5f9e6e::utils::destroy_or_transfer<T1>(0x2::coin::split<T1>(&mut arg4, 0x2::coin::value<T1>(&arg4) % arg5, arg6), arg6);
        0xcd94cda81a2bf85e40b43e909d2e83a927cd7db0e18a1de06950c5a7ef5f9e6e::utils::destroy_or_transfer<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

