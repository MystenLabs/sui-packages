module 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::stake_utils {
    public fun calculate_staking_pool_rewards(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: &0x3::staking_pool::PoolTokenExchangeRate, arg2: u64) : u64 {
        let v0 = get_sui_amount(arg1, get_token_amount(arg0, arg2));
        if (v0 >= arg2) {
            v0 - arg2
        } else {
            0
        }
    }

    public fun get_latest_exchange_rate(arg0: &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate>, arg1: u64) : &0x3::staking_pool::PoolTokenExchangeRate {
        while (arg1 > 0) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, arg1)) {
                return 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, arg1)
            };
            arg1 = arg1 - 1;
        };
        abort 0
    }

    fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        let v0 = 0x3::staking_pool::sui_amount(arg0);
        let v1 = 0x3::staking_pool::pool_token_amount(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v0 as u128) * (arg1 as u128) / (v1 as u128)) as u64)
    }

    fun get_token_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate, arg1: u64) : u64 {
        let v0 = 0x3::staking_pool::sui_amount(arg0);
        let v1 = 0x3::staking_pool::pool_token_amount(arg0);
        if (v0 == 0 || v1 == 0) {
            return arg1
        };
        (((v1 as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

