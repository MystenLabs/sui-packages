module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher {
    public entry fun compute_swap_result<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg6);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::compute_swap_result<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg7), arg1, arg2, arg3, arg4, true, arg5, arg7)
    }

    // decompiled from Move bytecode v6
}

