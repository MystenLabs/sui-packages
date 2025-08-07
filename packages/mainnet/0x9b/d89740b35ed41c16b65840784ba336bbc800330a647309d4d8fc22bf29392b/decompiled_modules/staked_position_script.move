module 0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::staked_position_script {
    public fun add_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg2: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::Minter<T2>, arg3: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg4: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg5: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg6: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>, arg7: 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::StakedPosition, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::StakedPosition {
        let v0 = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg13, arg14);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg13, arg14);
        0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::pool_script_v2::add_liquidity_by_fix_coin<T0, T1>(arg0, arg4, arg5, &mut v1, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::deposit_position<T0, T1>(arg0, arg1, arg6, arg5, v1, arg13, arg14)
    }

    public fun close_staked_position<T0, T1, T2, T3>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg2: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::Minter<T2>, arg3: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg4: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg5: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg6: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>, arg7: 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::StakedPosition, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg10, arg11);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg11));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::pool_script_v2::close_position<T0, T1>(arg0, arg4, arg5, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg10, arg11), arg8, arg9, arg10, arg11);
    }

    public fun open_position_and_stake_with_liquidity_by_fix_coin<T0, T1>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg2: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg3: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg4: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::StakedPosition {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::deposit_position<T0, T1>(arg0, arg1, arg4, arg3, 0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::pool_script_v2::open_position_with_liquidity_by_fix_coin_return<T0, T1>(arg0, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), arg12, arg13)
    }

    public fun remove_staked_liquidity_by_fix_coin<T0, T1, T2, T3>(arg0: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::config::GlobalConfig, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg2: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::Minter<T2>, arg3: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg4: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::rewarder::RewarderGlobalVault, arg5: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg6: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>, arg7: 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::StakedPosition, arg8: u128, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::StakedPosition {
        let v0 = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::get_position_reward<T0, T1, T2, T3>(arg2, arg3, arg1, arg6, arg5, &arg7, arg11, arg12);
        if (0x2::coin::value<T3>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v0, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::destroy_zero<T3>(v0);
        };
        let v1 = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::withdraw_position<T0, T1>(arg6, arg5, arg7, arg11, arg12);
        0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::pool_script_v2::remove_liquidity<T0, T1>(arg0, arg4, arg5, &mut v1, arg8, arg9, arg10, arg11, arg12);
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::deposit_position<T0, T1>(arg0, arg1, arg6, arg5, v1, arg11, arg12)
    }

    // decompiled from Move bytecode v6
}

