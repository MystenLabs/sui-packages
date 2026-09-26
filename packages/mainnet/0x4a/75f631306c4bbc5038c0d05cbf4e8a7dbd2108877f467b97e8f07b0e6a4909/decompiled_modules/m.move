module 0x4a75f631306c4bbc5038c0d05cbf4e8a7dbd2108877f467b97e8f07b0e6a4909::m {
    public fun a100<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        sa<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun a10000<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        sa<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun a3000<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        sa<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun a500<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        sa<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun b100<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        sb<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun b10000<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        sb<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun b3000<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        sb<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun b500<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        sb<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun ck(arg0: u128, arg1: u128, arg2: bool) {
        assert!(arg2 && arg0 >= arg1 || arg0 <= arg1, 101);
    }

    fun g<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        ck(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg1, arg2);
    }

    public fun g100<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>, arg1: u128, arg2: bool) {
        g<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>(arg0, arg1, arg2);
    }

    public fun g10000<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>, arg1: u128, arg2: bool) {
        g<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>(arg0, arg1, arg2);
    }

    public fun g3000<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>, arg1: u128, arg2: bool) {
        g<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>(arg0, arg1, arg2);
    }

    public fun g500<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg1: u128, arg2: bool) {
        g<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>(arg0, arg1, arg2);
    }

    fun sa<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(arg3, arg5));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T0>(&arg3), 0, arg4, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg1) + 60000, arg1, arg2, arg5);
        0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(v2));
        0x2::coin::into_balance<T1>(v1)
    }

    fun sb<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, 0x2::coin::from_balance<T1>(arg3, arg5));
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg0, v0, 0x2::balance::value<T1>(&arg3), 0, arg4, true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg1) + 60000, arg1, arg2, arg5);
        0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(v2));
        0x2::coin::into_balance<T0>(v1)
    }

    // decompiled from Move bytecode v7
}

