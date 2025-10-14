module 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::view {
    struct VeTokenData has copy, drop {
        ve_id: address,
        balance: u64,
        bond_mode: u8,
        unbond_at: u64,
        vote_power: u128,
        total_vote_power: u128,
        user_reward_amount: u64,
        last_claimed_epoch: u64,
    }

    public fun get_user_claim_reward_amount(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg2: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_token::VeToken) : u64 {
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::get_user_claim_reward_amount(arg1, arg0, arg2)
    }

    fun build_ve_token_data(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_token::VeToken, arg2: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg3: &0x2::clock::Clock) : VeTokenData {
        let (v0, v1, v2) = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_token::bond_info(arg1);
        let (v3, v4) = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::config_fields(arg0);
        let (_, v6, _, _) = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::get_user_reward_data(arg1);
        VeTokenData{
            ve_id              : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_token::id(arg1),
            balance            : v0,
            bond_mode          : v1,
            unbond_at          : v2,
            vote_power         : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::vote_power::vote_power_for_range(v3, v4, v0, 0x2::clock::timestamp_ms(arg3), v2),
            total_vote_power   : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::total_vote_power(arg2),
            user_reward_amount : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::get_user_claim_reward_amount(arg2, arg0, arg1),
            last_claimed_epoch : v6,
        }
    }

    public fun get_ts_epoch_start(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: u64) : u64 {
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::convert_to_epoch_start(0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::ep_config(arg0), arg1)
    }

    public fun get_ve_token(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_token::VeToken, arg2: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg3: &0x2::clock::Clock) : VeTokenData {
        build_ve_token_data(arg0, arg1, arg2, arg3)
    }

    public fun max_unbond_at(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg1) + 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::vote_power::max_bond_epochs(0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::vp_config(arg0)) * 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::epoch_interval_ms(0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::ep_config(arg0))
    }

    public fun preview_balance_change(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_token::VeToken, arg2: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg3: u64, arg4: &0x2::clock::Clock) : VeTokenData {
        let v0 = build_ve_token_data(arg0, arg1, arg2, arg4);
        let v1 = v0.balance + arg3;
        let (v2, v3) = 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::config_fields(arg0);
        VeTokenData{
            ve_id              : v0.ve_id,
            balance            : v1,
            bond_mode          : v0.bond_mode,
            unbond_at          : v0.unbond_at,
            vote_power         : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::vote_power::vote_power_for_range(v2, v3, v1, 0x2::clock::timestamp_ms(arg4), v0.unbond_at),
            total_vote_power   : v0.total_vote_power,
            user_reward_amount : v0.user_reward_amount,
            last_claimed_epoch : v0.last_claimed_epoch,
        }
    }

    public fun unpack_ve_token_data(arg0: &VeTokenData) : (address, u64, u8, u64, u128, u128, u64, u64) {
        (arg0.ve_id, arg0.balance, arg0.bond_mode, arg0.unbond_at, arg0.vote_power, arg0.total_vote_power, arg0.user_reward_amount, arg0.last_claimed_epoch)
    }

    // decompiled from Move bytecode v6
}

