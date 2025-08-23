module 0x63c9831619946ec46b49b0acc4cc10f434b31d634befd9392745396c6d56534b::liquidity_soft_lock_v1_script {
    public entry fun open_position_and_soft_lock_with_liquidity_by_fix_coin<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLocker, arg4: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::open_position<T0, T1>(arg0, arg2, arg5, arg6, arg14);
        let v1 = if (arg11) {
            arg9
        } else {
            arg10
        };
        0x63c9831619946ec46b49b0acc4cc10f434b31d634befd9392745396c6d56534b::pool_script_v2::repay_add_liquidity<T0, T1>(arg0, arg2, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, &mut v0, v1, arg11, arg13), arg7, arg8, arg9, arg10, arg14);
        let v2 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::lock_position<T0, T1>(arg0, arg1, arg3, arg4, arg2, v0, arg12, arg13, arg14);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&v2)) {
            0x2::transfer::public_transfer<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&mut v2), 0x2::tx_context::sender(arg14));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(v2);
    }

    public entry fun soft_lock_position<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLocker, arg4: &mut 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::pool_soft_tranche::PoolSoftTrancheManager, arg5: 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::position::Position, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::lock_position<T0, T1>(arg0, arg1, arg3, arg4, arg2, arg5, arg6, arg7, arg8);
        assert!(0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&v0) > 0, 939267347223);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&v0)) {
            0x2::transfer::public_transfer<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&mut v0), 0x2::tx_context::sender(arg8));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x4687103215a2ac5e8ed3383a846a342dd01e89610a3ee89eed9eaa1152d89465::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

