module 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::view {
    struct VeTokenData has copy, drop {
        ve_id: address,
        balance: u64,
        bond_mode: u8,
        unbond_at: u64,
        staked: bool,
        vote_power: u64,
        total_vote_power: u64,
        user_reward_amount: u64,
        last_claimed_epoch: u64,
    }

    fun build_ve_token_data(arg0: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_mmt::VeMMT, arg1: &mut 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::VeToken, arg2: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::StakingPool, arg3: &0x2::clock::Clock) : VeTokenData {
        let (v0, v1, v2) = 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::bond_info(arg1);
        let v3 = 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::calculate_ve_vote_power(arg1, arg0, v0, 0x2::clock::timestamp_ms(arg3));
        let v4 = get_user_claim_reward_amount(arg0, arg2, arg1);
        let (_, v6, _, _) = 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::get_user_reward_data(arg1);
        VeTokenData{
            ve_id              : 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::id(arg1),
            balance            : v0,
            bond_mode          : v1,
            unbond_at          : v2,
            staked             : 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::is_ve_staked(arg1),
            vote_power         : v3,
            total_vote_power   : 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::total_vote_power(arg2),
            user_reward_amount : v4,
            last_claimed_epoch : v6,
        }
    }

    public fun get_ts_epoch_start(arg0: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_mmt::VeMMT, arg1: u64) : u64 {
        0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::epoch::convert_to_epoch_start(0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_mmt::ep_config(arg0), arg1)
    }

    public fun get_user_claim_reward_amount(arg0: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_mmt::VeMMT, arg1: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::StakingPool, arg2: &mut 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::VeToken) : u64 {
        let (v0, _) = 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::get_user_claim_reward_data(arg1, arg0, arg2);
        (v0 as u64)
    }

    public fun get_ve_token(arg0: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_mmt::VeMMT, arg1: &mut 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::VeToken, arg2: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::StakingPool, arg3: &0x2::clock::Clock) : VeTokenData {
        build_ve_token_data(arg0, arg1, arg2, arg3)
    }

    public fun preview_balance_change(arg0: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_mmt::VeMMT, arg1: &mut 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::VeToken, arg2: &0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::staking_pool::StakingPool, arg3: u64, arg4: &0x2::clock::Clock) : VeTokenData {
        let v0 = build_ve_token_data(arg0, arg1, arg2, arg4);
        let v1 = v0.balance + arg3;
        VeTokenData{
            ve_id              : v0.ve_id,
            balance            : v1,
            bond_mode          : v0.bond_mode,
            unbond_at          : v0.unbond_at,
            staked             : v0.staked,
            vote_power         : 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::ve_token::calculate_ve_vote_power(arg1, arg0, v1, 0x2::clock::timestamp_ms(arg4)),
            total_vote_power   : v0.total_vote_power,
            user_reward_amount : v0.user_reward_amount,
            last_claimed_epoch : v0.last_claimed_epoch,
        }
    }

    public fun unpack_ve_token_data(arg0: &VeTokenData) : (address, u64, u8, u64, u64, u64, u64, u64) {
        (arg0.ve_id, arg0.balance, arg0.bond_mode, arg0.unbond_at, arg0.vote_power, arg0.total_vote_power, arg0.user_reward_amount, arg0.last_claimed_epoch)
    }

    // decompiled from Move bytecode v6
}

