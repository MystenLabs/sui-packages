module 0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::pool_script_v2 {
    fun swap<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg11: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg9, arg10, arg11, arg12);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg5) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg6) {
            assert!(v6 == arg7, 2);
            assert!(v7 >= arg8, 1);
        } else {
            assert!(v7 == arg7, 2);
            assert!(v6 <= arg8, 0);
        };
        let (v8, v9) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v6, arg13)))
        };
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap<T0, T1>(arg0, arg2, v8, v9, v3);
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg13));
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg13));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg13));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg13));
    }

    public entry fun add_liquidity<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg2, v0, arg4, arg5, arg6, arg7, arg10);
    }

    public entry fun add_liquidity_by_fix_coin<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg8) {
            arg6
        } else {
            arg7
        };
        let v1 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg3, v0, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg2, v1, arg4, arg5, arg6, arg7, arg10);
    }

    public fun add_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition {
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg13, arg14);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg13, arg14);
        let v2 = &mut v1;
        add_liquidity_by_fix_coin<T0, T1>(arg0, arg4, arg5, v2, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg6, arg5, v1, arg13, arg14)
    }

    public entry fun close_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::liquidity(&arg3);
        if (v0 > 0) {
            let v1 = &mut arg3;
            remove_liquidity<T0, T1>(arg0, arg1, arg2, v1, v0, arg4, arg5, arg6, arg7);
        };
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::close_position<T0, T1>(arg0, arg2, arg3);
    }

    public fun close_staked_position<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg10, arg11);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg10, arg11);
        close_position<T0, T1>(arg0, arg4, arg5, v1, arg8, arg9, arg10, arg11);
    }

    public entry fun collect_fee<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v1, arg5));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg5));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg5));
    }

    public entry fun collect_protocol_fee<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_protocol_fee<T0, T1>(arg0, arg1, arg4);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v0, arg4));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg4));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg4));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg4));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(&mut arg4, 0x2::coin::from_balance<T2>(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T2>(arg4, 0x2::tx_context::sender(arg6));
    }

    public entry fun create_pool<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: address, arg6: address, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::factory::create_pool<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun create_pool_with_liquidity<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::factory::Pools, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u32, arg9: u32, arg10: u64, arg11: u64, arg12: bool, arg13: address, arg14: address, arg15: bool, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::factory::create_pool_with_liquidity<T0, T1>(arg2, arg0, arg1, arg3, arg4, arg5, arg8, arg9, arg6, arg7, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg17));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T1>(v2, 0x2::tx_context::sender(arg17));
        0x2::transfer::public_transfer<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(v0, 0x2::tx_context::sender(arg17));
    }

    public entry fun initialize_rewarder<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::initialize_rewarder<T0, T1, T2>(arg0, arg1, arg2);
    }

    public entry fun open_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun open_position_and_stake_with_liquidity_by_fix_coin<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition {
        let v0 = open_position_with_liquidity_by_fix_coin_return<T0, T1>(arg0, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg4, arg3, v0, arg12, arg13)
    }

    public entry fun open_position_with_liquidity<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg2, arg3, arg4, arg11);
        let v1 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, &mut v0, arg9, arg10);
        repay_add_liquidity<T0, T1>(arg0, arg2, v1, arg5, arg6, arg7, arg8, arg11);
        0x2::transfer::public_transfer<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(v0, 0x2::tx_context::sender(arg11));
    }

    public entry fun open_position_with_liquidity_by_fix_coin<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg2, arg3, arg4, arg11);
        let v1 = if (arg9) {
            arg7
        } else {
            arg8
        };
        let v2 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, &mut v0, v1, arg9, arg10);
        repay_add_liquidity<T0, T1>(arg0, arg2, v2, arg5, arg6, arg7, arg8, arg11);
        0x2::transfer::public_transfer<0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun open_position_with_liquidity_by_fix_coin_return<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg2, arg3, arg4, arg11);
        let v1 = if (arg9) {
            arg7
        } else {
            arg8
        };
        let v2 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, &mut v0, v1, arg9, arg10);
        repay_add_liquidity<T0, T1>(arg0, arg2, v2, arg5, arg6, arg7, arg8, arg11);
        v0
    }

    public fun open_position_with_liquidity_return<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg2, arg3, arg4, arg11);
        let v1 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, &mut v0, arg9, arg10);
        repay_add_liquidity<T0, T1>(arg0, arg2, v1, arg5, arg6, arg7, arg8, arg11);
        v0
    }

    public entry fun pause_pool<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg4: u128, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg5, 1);
        assert!(0x2::balance::value<T1>(&v2) >= arg6, 1);
        let (v4, v5) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::collect_fee<T0, T1>(arg0, arg2, arg3, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v3, arg8), 0x2::tx_context::sender(arg8));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v2, arg8), 0x2::tx_context::sender(arg8));
    }

    public fun remove_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: u128, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition {
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg11, arg12);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg11, arg12);
        let v2 = &mut v1;
        remove_liquidity<T0, T1>(arg0, arg4, arg5, v2, arg8, arg9, arg10, arg11, arg12);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg6, arg5, v1, arg11, arg12)
    }

    public(friend) fun repay_add_liquidity<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::AddLiquidityReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v0 <= arg5, 0);
        assert!(v1 <= arg6, 0);
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v1, arg7)), arg2);
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg7));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg7));
    }

    public entry fun set_display<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::set_display<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun swap_a2b<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg10: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, true, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun swap_a2b_with_partner<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg11: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, true, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public entry fun swap_b2a<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg10: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, false, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun swap_b2a_with_partner<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg11: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, false, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun swap_with_partner<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg12: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg10, arg11, arg12, arg13);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg6) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg7) {
            assert!(v6 == arg8, 2);
            assert!(v7 >= arg9, 1);
        } else {
            assert!(v7 == arg8, 2);
            assert!(v6 <= arg9, 0);
        };
        let (v8, v9) = if (arg6) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v6, arg14)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v6, arg14)))
        };
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg2, arg3, v8, v9, v3);
        0x2::coin::join<T1>(&mut arg5, 0x2::coin::from_balance<T1>(v4, arg14));
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v5, arg14));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T0>(arg4, 0x2::tx_context::sender(arg14));
        0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::utils::send_coin<T1>(arg5, 0x2::tx_context::sender(arg14));
    }

    public entry fun unpause_pool<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::unpause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun update_fee_rate<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::update_fee_rate<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_pool_url<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::update_pool_url<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

