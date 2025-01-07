module 0x652c97317f1e6e84b0e83f2e353ada085beb3123a0a25c6d96cc3686ab569527::deepbook {
    public fun deepbook_base_for_quote<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T0>(&arg3), arg3, 0x2::coin::zero<T1>(arg6), arg4, arg6);
        0x652c97317f1e6e84b0e83f2e353ada085beb3123a0a25c6d96cc3686ab569527::utils::destroy_or_transfer<T0>(0x2::coin::split<T0>(&mut arg3, 0x2::coin::value<T0>(&arg3) % arg5, arg6), arg6);
        0x652c97317f1e6e84b0e83f2e353ada085beb3123a0a25c6d96cc3686ab569527::utils::destroy_or_transfer<T0>(v0, arg6);
        v1
    }

    public fun deepbook_quote_for_base<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T1>(&arg4), arg3, arg4, arg6);
        0x652c97317f1e6e84b0e83f2e353ada085beb3123a0a25c6d96cc3686ab569527::utils::destroy_or_transfer<T1>(v1, arg6);
        v0
    }

    // decompiled from Move bytecode v6
}

