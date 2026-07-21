module 0x573ad1b30290a669ca7f309898f001a86ef6cf3770f2e37f70cbbc17e85fe185::turbos_clmm {
    fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun turbos_clmm_add_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg5);
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, arg6);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg0, arg1, v0, v1, arg4, 0x2::coin::value<T0>(&arg5), 0x2::coin::value<T1>(&arg6), 0, 0, 0x2::clock::timestamp_ms(arg3), arg3, arg2, arg7)
    }

    public fun turbos_clmm_close_position<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg0, arg2, arg1, arg3);
    }

    public fun turbos_clmm_collect_fee<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg0, arg1, arg4, 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3), arg3, arg2, arg5)
    }

    public fun turbos_clmm_collect_reward<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg0, arg2, arg5, arg1, arg6, 18446744073709551615, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg4), arg4, arg3, arg7)
    }

    public fun turbos_clmm_flashswap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg5), true, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::from_lo_hi(arg3, 0), true, arg4, arg2, arg1, arg5);
        0x2::coin::destroy_zero<T0>(v0);
        (v1, v2)
    }

    public fun turbos_clmm_flashswap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg5), false, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::from_lo_hi(arg3, 0), true, arg4, arg2, arg1, arg5);
        0x2::coin::destroy_zero<T1>(v1);
        (v0, v2)
    }

    public fun turbos_clmm_open_position<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg6);
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, arg7);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg4);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg5);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg0, arg1, v0, v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v3), 0x2::coin::value<T0>(&arg6), 0x2::coin::value<T1>(&arg7), 0, 0, 0x2::clock::timestamp_ms(arg3), arg3, arg2, arg8)
    }

    public fun turbos_clmm_remove_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg5 == 0) {
            let (_, _, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4));
            arg5 = v2;
        };
        let (v3, v4) = if (arg5 > 0) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg0, arg1, arg4, arg5, 0, 0, 0x2::clock::timestamp_ms(arg3), arg3, arg2, arg6)
        } else {
            (0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6))
        };
        let v5 = v4;
        let v6 = v3;
        let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg0, arg1, arg4, 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg6), 0x2::clock::timestamp_ms(arg3), arg3, arg2, arg6);
        0x2::coin::join<T0>(&mut v6, v7);
        0x2::coin::join<T1>(&mut v5, v8);
        (v6, v5)
    }

    public fun turbos_clmm_repay_flashswap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::coin::Coin<T0>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, arg2, 0x2::coin::zero<T1>(arg4), arg3, arg1);
    }

    public fun turbos_clmm_repay_flashswap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: 0x2::coin::Coin<T1>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::FlashSwapReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg4), arg2, arg3, arg1);
    }

    public fun turbos_clmm_swap_a2b<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg5), true, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::from_lo_hi(0x2::coin::value<T0>(&arg3), 0), true, arg4, arg2, arg1, arg5);
        0x2::coin::destroy_zero<T0>(v0);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, arg3, 0x2::coin::zero<T1>(arg5), v2, arg1);
        v1
    }

    public fun turbos_clmm_swap_b2a<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg5), false, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_u128::from_lo_hi(0x2::coin::value<T1>(&arg3), 0), true, arg4, arg2, arg1, arg5);
        0x2::coin::destroy_zero<T1>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg5), arg3, v2, arg1);
        v0
    }

    // decompiled from Move bytecode v7
}

