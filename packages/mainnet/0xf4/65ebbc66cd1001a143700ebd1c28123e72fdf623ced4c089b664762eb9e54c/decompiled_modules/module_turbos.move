module 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_turbos {
    public(friend) fun add_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::OpenParams, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        let v0 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_fixed_amount(&arg5);
        let v1 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_deduction(&arg5);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mod_euclidean(v3, v2));
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_lower_mult(&arg5) * v2));
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_upper_mult(&arg5) * v2));
        let v7 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        let (v9, v10) = if (0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_is_fixed_a(&arg5)) {
            let v11 = if (v0 > 0) {
                v0
            } else {
                assert!(0x2::coin::value<T0>(arg3) > v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_x());
                0x2::coin::value<T0>(arg3) - v1
            };
            (v11, 0x2::coin::value<T1>(arg4))
        } else {
            let v12 = if (v0 > 0) {
                v0
            } else {
                assert!(0x2::coin::value<T1>(arg4) > v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_y());
                0x2::coin::value<T1>(arg4) - v1
            };
            (0x2::coin::value<T0>(arg3), v12)
        };
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v7, 0x2::coin::split<T0>(arg3, v9, arg7));
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::split<T1>(arg4, v10, arg7));
        let (v13, v14, v15) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg0, arg1, v7, v8, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(v6), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(v6), v9, v10, 0, 0, deadline_ms(arg6), arg6, arg2, arg7);
        0x2::coin::join<T0>(arg3, v14);
        0x2::coin::join<T1>(arg4, v15);
        v13
    }

    public(friend) fun burn_position<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (_, _, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg2));
        let v3 = 0x2::coin::zero<T0>(arg5);
        let v4 = 0x2::coin::zero<T1>(arg5);
        if (v2 > 0) {
            let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg0, arg1, &mut arg2, v2, 0, 0, deadline_ms(arg3), arg3, arg4, arg5);
            0x2::coin::join<T0>(&mut v3, v5);
            0x2::coin::join<T1>(&mut v4, v6);
        };
        let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg0, arg1, &mut arg2, 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg5), deadline_ms(arg3), arg3, arg4, arg5);
        0x2::coin::join<T0>(&mut v3, v7);
        0x2::coin::join<T1>(&mut v4, v8);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg1, arg2, arg4, arg5);
        (v3, v4)
    }

    public(friend) fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 18446744073709551615, 0x2::tx_context::sender(arg7), deadline_ms(arg5), arg5, arg6, arg7)
    }

    fun deadline_ms(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) + 600000
    }

    // decompiled from Move bytecode v7
}

