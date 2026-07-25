module 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::turbos_ops {
    struct TurbosSniped has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        buy_sui: u64,
    }

    struct TurbosSold has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_in: u64,
        sui_out: u64,
    }

    fun deposit_optional<T0>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::deposit_coin<T0>(arg0, arg1);
        };
    }

    fun push_coin<T0>(arg0: &mut vector<0x2::coin::Coin<T0>>, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x1::vector::push_back<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun sell_turbos<T0, T1>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::assert_authorized(arg0, arg5);
        let v0 = 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::withdraw_coin<T0>(arg0, arg3, arg5);
        let v1 = swap_token_to_sui<T0, T1>(arg0, arg1, v0, arg4, arg2, arg5);
        let v2 = TurbosSold{
            vault_id : 0x2::object::id<0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault>(arg0),
            pool_id  : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg1),
            token_in : 0x2::coin::value<T0>(&v0),
            sui_out  : 0x2::coin::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<TurbosSold>(v2);
        v1
    }

    public fun snip_and_lp_turbos<T0, T1>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u32, arg7: bool, arg8: u32, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::assert_authorized(arg0, arg16);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>>(arg1);
        let v1 = swap_sui_to_token<T0, T1>(arg0, arg1, arg4, arg15, arg3, arg16);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v3 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        let v4 = &mut v2;
        push_coin<T0>(v4, v1);
        let v5 = &mut v3;
        push_coin<0x2::sui::SUI>(v5, arg5);
        let (v6, v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, 0x2::sui::SUI, T1>(arg1, arg2, v2, v3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg3, arg16);
        deposit_optional<T0>(arg0, v7);
        deposit_optional<0x2::sui::SUI>(arg0, v8);
        0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::store_position_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg0, v0, v6);
        let v9 = TurbosSniped{
            vault_id : 0x2::object::id<0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault>(arg0),
            pool_id  : v0,
            buy_sui  : 0x2::coin::value<0x2::sui::SUI>(&arg4),
        };
        0x2::event::emit<TurbosSniped>(v9);
    }

    fun swap_sui_to_token<T0, T1>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, arg2);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, 0x2::sui::SUI, T1>(arg1, v0, 0x2::coin::value<0x2::sui::SUI>(&arg2), 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3) + 18000, arg3, arg4, arg5);
        deposit_optional<0x2::sui::SUI>(arg0, v2);
        v1
    }

    fun swap_token_to_sui<T0, T1>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg2);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, 0x2::sui::SUI, T1>(arg1, v0, 0x2::coin::value<T0>(&arg2), 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3) + 18000, arg3, arg4, arg5);
        deposit_optional<T0>(arg0, v2);
        v1
    }

    // decompiled from Move bytecode v7
}

