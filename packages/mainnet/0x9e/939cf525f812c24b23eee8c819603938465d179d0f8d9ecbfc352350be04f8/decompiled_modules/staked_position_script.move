module 0x9e939cf525f812c24b23eee8c819603938465d179d0f8d9ecbfc352350be04f8::staked_position_script {
    public fun add_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition {
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg13, arg14);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg13, arg14);
        0x9e939cf525f812c24b23eee8c819603938465d179d0f8d9ecbfc352350be04f8::pool_script_v2::add_liquidity_by_fix_coin<T0, T1>(arg0, arg4, arg5, &mut v1, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg6, arg5, v1, arg13, arg14)
    }

    public fun close_staked_position<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg10, arg11);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        0x9e939cf525f812c24b23eee8c819603938465d179d0f8d9ecbfc352350be04f8::pool_script_v2::close_position<T0, T1>(arg0, arg4, arg5, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg10, arg11), arg8, arg9, arg10, arg11);
    }

    public fun open_position_and_stake_with_liquidity_by_fix_coin<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition {
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg4, arg3, 0x9e939cf525f812c24b23eee8c819603938465d179d0f8d9ecbfc352350be04f8::pool_script_v2::open_position_with_liquidity_by_fix_coin_return<T0, T1>(arg0, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), arg12, arg13)
    }

    public fun remove_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::Minter<T2>, arg3: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::voter::Voter, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg5: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg6: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: u128, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition {
        let v0 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg11, arg12);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg11, arg12);
        0x9e939cf525f812c24b23eee8c819603938465d179d0f8d9ecbfc352350be04f8::pool_script_v2::remove_liquidity<T0, T1>(arg0, arg4, arg5, &mut v1, arg8, arg9, arg10, arg11, arg12);
        0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg6, arg5, v1, arg11, arg12)
    }

    // decompiled from Move bytecode v6
}

