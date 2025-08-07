module 0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::liquidity_soft_lock_v1_script {
    public entry fun open_position_and_soft_lock_with_liquidity_by_fix_coin<T0, T1>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg2: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg3: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLocker, arg4: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::pool_soft_tranche::PoolSoftTrancheManager, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::open_position<T0, T1>(arg0, arg2, arg5, arg6, arg14);
        let v1 = if (arg11) {
            arg9
        } else {
            arg10
        };
        0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::pool_script_v2::repay_add_liquidity<T0, T1>(arg0, arg2, 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, &mut v0, v1, arg11, arg13), arg7, arg8, arg9, arg10, arg14);
        let v2 = 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::lock_position<T0, T1>(arg0, arg1, arg3, arg4, arg2, v0, arg12, arg13, arg14);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&v2)) {
            0x2::transfer::public_transfer<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&mut v2), 0x2::tx_context::sender(arg14));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(v2);
    }

    public entry fun soft_lock_position<T0, T1>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg2: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg3: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLocker, arg4: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::pool_soft_tranche::PoolSoftTrancheManager, arg5: 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::position::Position, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::lock_position<T0, T1>(arg0, arg1, arg3, arg4, arg2, arg5, arg6, arg7, arg8);
        assert!(0x1::vector::length<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&v0) > 0, 939267347223);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&v0)) {
            0x2::transfer::public_transfer<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(&mut v0), 0x2::tx_context::sender(arg8));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v1::SoftLockedPosition<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

