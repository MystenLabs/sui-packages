module 0xfa5560ff4c1b8eef703478ef50f175dace21ec5a6bf073fb7635eb5b77d6baf3::fingerprint {
    public fun assert_fp(arg0: u128, arg1: u128) {
        assert!(arg0 == arg1, 1000);
    }

    public fun cetus_pool_fp<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg0);
        compute_fp(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), 0x2::balance::value<T0>(v0), 0x2::balance::value<T1>(v1))
    }

    public fun compute_fp(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : u128 {
        arg0 ^ arg1 ^ (arg2 as u128) ^ (arg3 as u128)
    }

    public fun turbos_pool_fp<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : u128 {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg0);
        compute_fp(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), v0, v1)
    }

    // decompiled from Move bytecode v7
}

