module 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::turbos {
    public(friend) fun ta<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::get_coin_vec<T0>(arg0), 0x2::coin::value<T0>(&arg0), arg2, arg3, true, arg5, 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::get_deadline(arg6), arg6, arg4, arg7)
    }

    public(friend) fun ta_<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::wallet::Vault<T0>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = ta<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::wallet::deposit_or_destroy<T0>(arg7, v1);
        v0
    }

    public(friend) fun ta__<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::wallet::Vault<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::join<T1>(ta_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8)
    }

    public(friend) fun tb<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::get_coin_vec<T1>(arg0), 0x2::coin::value<T1>(&arg0), arg2, arg3, true, arg5, 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::get_deadline(arg6), arg6, arg4, arg7)
    }

    public(friend) fun tb_<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::wallet::Vault<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = tb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::wallet::deposit_or_destroy<T1>(arg7, v1);
        v0
    }

    public(friend) fun tb__<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::wallet::Vault<T1>, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::join<T0>(tb_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8)
    }

    public fun test_ta<T0, T1, T2>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u128, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::admin::get_address();
        let v1 = 0x2::coin::split<T0>(arg0, arg1, arg7);
        let (v2, v3) = ta<T0, T1, T2>(v1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
        let v4 = v3;
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::send_coin<T1>(v2, v0);
        if (0x2::coin::value<T0>(&v4) == 0) {
            0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::destroy_zero<T0>(v4);
        } else {
            0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::send_coin<T0>(v4, v0);
        };
    }

    public fun test_tb<T0, T1, T2>(arg0: &mut 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u64, arg4: u128, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::admin::get_address();
        let v1 = 0x2::coin::split<T1>(arg0, arg1, arg7);
        let (v2, v3) = tb<T0, T1, T2>(v1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
        let v4 = v3;
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::send_coin<T0>(v2, v0);
        if (0x2::coin::value<T1>(&v4) == 0) {
            0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::destroy_zero<T1>(v4);
        } else {
            0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::send_coin<T1>(v4, v0);
        };
    }

    // decompiled from Move bytecode v6
}

