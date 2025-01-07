module 0xbdd32eb73a2535b163cc03e4dbea72ba08996a0c9fd323b92f06d1fda524d62c::deepbook {
    public fun deepbook_base_for_quote<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::split<T0>(&mut arg3, 0x2::coin::value<T0>(&arg3) % arg5, arg6);
        let (v1, v2, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T0>(&v0), v0, 0x2::coin::zero<T1>(arg6), arg4, arg6);
        0xbdd32eb73a2535b163cc03e4dbea72ba08996a0c9fd323b92f06d1fda524d62c::utils::destroy_or_transfer<T0>(arg3, arg6);
        0xbdd32eb73a2535b163cc03e4dbea72ba08996a0c9fd323b92f06d1fda524d62c::utils::destroy_or_transfer<T0>(v1, arg6);
        v2
    }

    public fun deepbook_quote_for_base<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: &0xdee9::custodian_v2::AccountCap, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::split<T1>(&mut arg4, 0x2::coin::value<T1>(&arg4) % arg5, arg6);
        let (v1, v2, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T1>(&v0), arg3, v0, arg6);
        0xbdd32eb73a2535b163cc03e4dbea72ba08996a0c9fd323b92f06d1fda524d62c::utils::destroy_or_transfer<T1>(arg4, arg6);
        0xbdd32eb73a2535b163cc03e4dbea72ba08996a0c9fd323b92f06d1fda524d62c::utils::destroy_or_transfer<T1>(v2, arg6);
        v1
    }

    // decompiled from Move bytecode v6
}

