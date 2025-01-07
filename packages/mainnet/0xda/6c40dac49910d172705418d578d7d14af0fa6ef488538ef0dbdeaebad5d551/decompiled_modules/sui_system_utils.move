module 0xda6c40dac49910d172705418d578d7d14af0fa6ef488538ef0dbdeaebad5d551::sui_system_utils {
    public fun calculate_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: &0x2::tx_context::TxContext) : u64 {
        calculate_rewards_at_epoch(arg0, arg1, 0x2::tx_context::epoch(arg2))
    }

    public fun calculate_rewards_at_epoch(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        let v0 = 0x3::staking_pool::staked_sui_amount(arg1);
        let v1 = pool_token_exchange_rate_at_epoch(arg0, arg1, arg2);
        let v2 = pool_token_exchange_rate_at_epoch(arg0, arg1, 0x3::staking_pool::stake_activation_epoch(arg1));
        let v3 = get_sui_amount(&v1, get_token_amount(&v2, v0));
        if (v3 >= v0) {
            v3 - v0
        } else {
            0
        }
    }

    fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        if (0x3::staking_pool::sui_amount(arg0) == 0 || 0x3::staking_pool::pool_token_amount(arg0) == 0) {
            return arg1
        };
        (((0x3::staking_pool::sui_amount(arg0) as u128) * (arg1 as u128) / (0x3::staking_pool::pool_token_amount(arg0) as u128)) as u64)
    }

    fun get_token_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        if (0x3::staking_pool::sui_amount(arg0) == 0 || 0x3::staking_pool::pool_token_amount(arg0) == 0) {
            return arg1
        };
        (((0x3::staking_pool::pool_token_amount(arg0) as u128) * (arg1 as u128) / (0x3::staking_pool::sui_amount(arg0) as u128)) as u64)
    }

    public fun is_validator_active(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &address) : bool {
        let v0 = 0x3::sui_system::active_validator_addresses(arg0);
        0x1::vector::contains<address>(&v0, arg1)
    }

    public fun pool_token_exchange_rate_at_epoch(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : 0x3::staking_pool::PoolTokenExchangeRate {
        let v0 = 0x3::staking_pool::stake_activation_epoch(arg1);
        assert!(arg2 >= v0, 42);
        let v1 = 0x3::staking_pool::pool_id(arg1);
        let v2 = 0x3::sui_system::pool_exchange_rates(arg0, &v1);
        if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v2, arg2)) {
            return *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v2, arg2)
        };
        let v3 = arg2;
        while (v0 < v3) {
            let v4 = v0 + (v3 - v0) / 2;
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v2, v4)) {
                v0 = v4 + 1;
                continue
            };
            v3 = v4;
        };
        *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v2, v3 - 1)
    }

    public fun request_withdraw_stake_vec_non_entry(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: vector<0x3::staking_pool::StakedSui>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg1)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x3::sui_system::request_withdraw_stake_non_entry(arg0, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut arg1), arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(arg1);
        v0
    }

    public fun staked_sui_principal_and_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        (0x3::staking_pool::staked_sui_amount(arg1), calculate_rewards(arg0, arg1, arg2))
    }

    // decompiled from Move bytecode v6
}

