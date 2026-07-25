module 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::bluefin_ops {
    struct BluefinSniped has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        buy_sui: u64,
        token_received: u64,
        token_for_lp: u64,
    }

    struct BluefinSold has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_in: u64,
        sui_out: u64,
    }

    fun deposit_balance_optional<T0>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::deposit_balance<T0>(arg0, arg1);
        };
    }

    fun destroy_balance_zero<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun sell_bluefin<T0>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::assert_authorized(arg0, arg5);
        let v0 = 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::withdraw_coin<T0>(arg0, arg3, arg5);
        let v1 = swap_a2b<T0>(arg1, arg2, v0, arg4, arg5);
        let v2 = BluefinSold{
            vault_id : 0x2::object::id<0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault>(arg0),
            pool_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2),
            token_in : 0x2::coin::value<T0>(&v0),
            sui_out  : 0x2::coin::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<BluefinSold>(v2);
        v1
    }

    public fun snip_and_lp_bluefin<T0>(arg0: &mut 0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u32, arg5: u32, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::assert_authorized(arg0, arg8);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        let v1 = swap_b2a<T0>(arg1, arg2, arg3, arg7, arg8);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = if (arg6 > v2) {
            v2
        } else {
            arg6
        };
        assert!(v3 > 0, 13906834427746451457);
        if (0x2::coin::value<T0>(&v1) > 0) {
            0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::deposit_coin<T0>(arg0, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg1, arg2, arg4, arg5, arg8);
        let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg7, arg1, arg2, &mut v4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, v3, arg8)), 0x2::balance::zero<0x2::sui::SUI>(), v3, true);
        deposit_balance_optional<T0>(arg0, v7);
        deposit_balance_optional<0x2::sui::SUI>(arg0, v8);
        0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::store_position_object<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, v0, v4);
        let v9 = BluefinSniped{
            vault_id       : 0x2::object::id<0x2d15e1ee3b73c591061f8f3172f2a118f84ecb9b469e18dbc96a4715abd0f6cc::vault::Vault>(arg0),
            pool_id        : v0,
            buy_sui        : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            token_received : v2,
            token_for_lp   : v3,
        };
        0x2::event::emit<BluefinSniped>(v9);
    }

    fun swap_a2b<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0x2::sui::SUI>(arg3, arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<0x2::sui::SUI>(), true, true, 0x2::coin::value<T0>(&arg2), 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1);
        destroy_balance_zero<T0>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4)
    }

    fun swap_b2a<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0x2::sui::SUI>(arg3, arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(arg2), false, true, 0x2::coin::value<0x2::sui::SUI>(&arg2), 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1);
        destroy_balance_zero<0x2::sui::SUI>(v1);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v7
}

