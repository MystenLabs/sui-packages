module 0x24b2822f663de68cf8db045785e06cdd6b3aabf3cf1decbfce0e105c45142997::magma_clmm {
    public fun magma_clmm_add_liquidity<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(arg3);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(v1);
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(v2);
        if (arg6 != 0) {
            if (arg6 >= v4) {
                assert!(v0 >= v4, 0);
            } else if (arg6 <= v3) {
                assert!(v0 <= v3, 0);
            } else {
                assert!(v0 == arg6, 0);
            };
        };
        let v5 = 0;
        let v6 = 0;
        if (v0 < v4) {
            let v7 = if (v0 <= v3) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_a(v3, v4, 0x2::coin::value<T0>(&arg4), false)
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_a(v0, v4, 0x2::coin::value<T0>(&arg4), false)
            };
            v5 = v7;
        };
        if (v0 > v3) {
            let v8 = if (v0 >= v4) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_b(v3, v4, 0x2::coin::value<T1>(&arg5), false)
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_from_b(v3, v0, 0x2::coin::value<T1>(&arg5), false)
            };
            v6 = v8;
        };
        let v9 = if (v0 <= v3) {
            v5
        } else if (v0 >= v4) {
            v6
        } else if (v5 < v6) {
            v5
        } else {
            v6
        };
        if (v9 == 0) {
            return (arg4, arg5)
        };
        let v10 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity<T0, T1>(arg1, arg0, arg3, v9, arg2, arg7);
        let v11 = 0x2::coin::into_balance<T0>(arg4);
        let v12 = 0x2::coin::into_balance<T1>(arg5);
        let (v13, v14) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v10);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg1, arg0, 0x2::balance::split<T0>(&mut v11, v13), 0x2::balance::split<T1>(&mut v12, v14), v10);
        (0x2::coin::from_balance<T0>(v11, arg7), 0x2::coin::from_balance<T1>(v12, arg7))
    }

    public fun magma_clmm_close_position<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position) {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg1, arg0, arg2);
    }

    public fun magma_clmm_collect_fee<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg2, arg0, arg4, true);
        let v2 = v1;
        let v3 = v0;
        if (arg5) {
            0x2::balance::join<T0>(&mut v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T0>(arg2, arg0, arg4, arg1, false, arg3));
        };
        if (arg6) {
            0x2::balance::join<T1>(&mut v2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T1>(arg2, arg0, arg4, arg1, false, arg3));
        };
        (0x2::coin::from_balance<T0>(v3, arg7), 0x2::coin::from_balance<T1>(v2, arg7))
    }

    public fun magma_clmm_collect_reward<T0, T1, T2>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg2, arg0, arg4, arg1, false, arg3), arg5)
    }

    public fun magma_clmm_flashswap_a2b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg0, true, true, arg3, arg4, arg2);
        0x2::balance::destroy_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg5), v2)
    }

    public fun magma_clmm_flashswap_b2a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg0, false, true, arg3, arg4, arg2);
        0x2::balance::destroy_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg5), v2)
    }

    public fun magma_clmm_open_position<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg1, arg0, arg2, arg3, arg4)
    }

    public fun magma_clmm_remove_liquidity<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, arg5: u128, arg6: u128, arg7: bool, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg6 != 0) {
            let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::tick_range(arg4);
            let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(v0);
            let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(v1);
            if (arg6 >= v3) {
                assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0) >= v3, 0);
            } else if (arg6 <= v2) {
                assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0) <= v2, 0);
            } else {
                assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0) == arg6, 0);
            };
        };
        if (arg5 == 0) {
            arg5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(arg4);
        };
        let (v4, v5) = if (arg5 > 0) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg2, arg0, arg4, arg5, arg3)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg2, arg0, arg4, false);
        0x2::balance::join<T0>(&mut v7, v8);
        0x2::balance::join<T1>(&mut v6, v9);
        if (arg7) {
            0x2::balance::join<T0>(&mut v7, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T0>(arg2, arg0, arg4, arg1, false, arg3));
        };
        if (arg8) {
            0x2::balance::join<T1>(&mut v6, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T1>(arg2, arg0, arg4, arg1, false, arg3));
        };
        (0x2::coin::from_balance<T0>(v7, arg9), 0x2::coin::from_balance<T1>(v6, arg9))
    }

    public fun magma_clmm_repay_flashswap_a2b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg3);
    }

    public fun magma_clmm_repay_flashswap_b2a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg3);
    }

    public fun magma_clmm_swap_a2b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg0, true, true, 0x2::coin::value<T0>(&arg3), arg4, arg2);
        0x2::balance::destroy_zero<T0>(v0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v2);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun magma_clmm_swap_b2a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg0, false, true, 0x2::coin::value<T1>(&arg3), arg4, arg2);
        0x2::balance::destroy_zero<T1>(v1);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), v2);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

