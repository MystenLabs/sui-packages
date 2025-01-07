module 0xff7733fe18fc30cfb60bada75fa756135c54ee8c6db50efd22f5a18ce5e43c21::stake_data_provider {
    fun calculate_apy(arg0: &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate>, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > arg2, 1);
        let v0 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, arg1);
        let v1 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, arg2);
        (((0x3::staking_pool::sui_amount(v0) as u256) * (0x3::staking_pool::pool_token_amount(v1) as u256) / (1000000000 as u256) * (1000000000 as u256) / (0x3::staking_pool::sui_amount(v1) as u256) * (0x3::staking_pool::pool_token_amount(v0) as u256) / (1000000000 as u256) - (1000000000 as u256)) as u64) * 365 / (arg1 - arg2)
    }

    public fun earnings_from_staked_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        let v0 = 0x3::staking_pool::stake_activation_epoch(arg1);
        let v1 = 0x3::staking_pool::staked_sui_amount(arg1);
        let v2 = 0x3::staking_pool::pool_id(arg1);
        assert!(arg2 > v0, 2);
        let v3 = 0x3::sui_system::pool_exchange_rates(arg0, &v2);
        while (arg2 >= v0) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v3, arg2)) {
                v0 = arg2 + 1;
            };
            arg2 = arg2 - 1;
        };
        let v4 = get_sui_amount(0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v3, v0), get_token_amount(0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v3, v0), v1));
        if (v4 >= v1) {
            v4 - v1
        } else {
            0
        }
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

    public fun pool_apy(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::object::ID, arg2: u64) : u64 {
        let v0 = 0x3::sui_system::pool_exchange_rates(arg0, arg1);
        assert!(0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, arg2), 2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v2 < 30) {
            if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, arg2 - v2)) {
                let v4 = 1;
                while (v4 < 10) {
                    if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, arg2 - v2 - v4)) {
                        break
                    };
                    v4 = v4 + 1;
                };
                if (0x2::table::contains<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v0, arg2 - v2 - v4)) {
                    v1 = v1 + calculate_apy(v0, arg2 - v2, arg2 - v2 - v4);
                    v3 = v3 + 1;
                };
            };
            v2 = v2 + 1;
        };
        v1 / v3
    }

    // decompiled from Move bytecode v6
}

