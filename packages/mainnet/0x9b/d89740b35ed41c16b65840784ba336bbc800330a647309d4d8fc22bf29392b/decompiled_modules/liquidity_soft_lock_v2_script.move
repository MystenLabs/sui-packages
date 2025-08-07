module 0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::liquidity_soft_lock_v2_script {
    public entry fun lock_position_v2<T0, T1>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg2: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg3: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLocker, arg4: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::pool_soft_tranche::PoolSoftTrancheManager, arg5: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>, arg6: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg7: 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::StakedPosition, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::lock_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        assert!(0x1::vector::length<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&v0) > 0, 939267347223);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&v0)) {
            0x2::transfer::public_transfer<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&mut v0), 0x2::tx_context::sender(arg10));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(v0);
    }

    public fun open_position_and_stake_and_lock_v2<T0, T1>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg2: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg3: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg4: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>, arg5: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLocker, arg6: &mut 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::pool_soft_tranche::PoolSoftTrancheManager, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::lock_position<T0, T1>(arg0, arg2, arg1, arg5, arg6, arg4, arg3, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::deposit_position<T0, T1>(arg0, arg1, arg4, arg3, 0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::pool_script_v2::open_position_with_liquidity_by_fix_coin_return<T0, T1>(arg0, arg2, arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16), arg15, arg16), arg14, arg15, arg16);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&v0)) {
            0x2::transfer::public_transfer<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(0x1::vector::pop_back<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(&mut v0), 0x2::tx_context::sender(arg16));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xfa4b355e4676c156beb757316853fa12e70a0a063ff246de11813b64e3396b90::liquidity_soft_lock_v2::SoftLockedPosition<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

