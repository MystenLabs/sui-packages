module 0x62717e7025e96bd834f5bee177d35b9a9fd71a4986ee028c2ce5c1226d2d279e::liquidity_soft_lock_v2_script {
    public entry fun lock_position_v2<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg3: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLocker, arg4: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg5: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg6: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg7: 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::StakedPosition, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::lock_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        assert!(0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&v0) > 0, 939267347223);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&v0)) {
            0x2::transfer::public_transfer<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&mut v0), 0x2::tx_context::sender(arg10));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(v0);
    }

    public fun open_position_and_stake_and_lock_v2<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::distribution_config::DistributionConfig, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg4: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::Gauge<T0, T1>, arg5: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLocker, arg6: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::lock_position<T0, T1>(arg0, arg2, arg1, arg5, arg6, arg4, arg3, 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::gauge::deposit_position<T0, T1>(arg0, arg1, arg4, arg3, 0x62717e7025e96bd834f5bee177d35b9a9fd71a4986ee028c2ce5c1226d2d279e::pool_script_v2::open_position_with_liquidity_by_fix_coin_return<T0, T1>(arg0, arg2, arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16), arg15, arg16), arg14, arg15, arg16);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&v0)) {
            0x2::transfer::public_transfer<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&mut v0), 0x2::tx_context::sender(arg16));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

