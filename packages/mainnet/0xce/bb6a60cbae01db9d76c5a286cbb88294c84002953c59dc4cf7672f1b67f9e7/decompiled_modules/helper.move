module 0xcebb6a60cbae01db9d76c5a286cbb88294c84002953c59dc4cf7672f1b67f9e7::helper {
    public fun calculate_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg3 >= arg4) {
            return 0
        };
        let v0 = 0x3::sui_system::pool_exchange_rates(arg0, &arg1);
        let v1 = pool_token_exchange_rate_at_epoch(v0, arg3);
        let v2 = get_sui_amount(&v1);
        let v3 = pool_token_exchange_rate_at_epoch(v0, arg4);
        let v4 = if (v2 == 0) {
            (0xc2bf9f87215ddb3215914bee887281a64bbb893dd92580186c98fff62842840b::math::mul_div_u256((arg2 as u256), (0xc2bf9f87215ddb3215914bee887281a64bbb893dd92580186c98fff62842840b::math::mul_to_u128(get_sui_amount(&v3), 1) as u256), (0xc2bf9f87215ddb3215914bee887281a64bbb893dd92580186c98fff62842840b::math::mul_to_u128(1, get_token_amount(&v3)) as u256)) as u64)
        } else {
            (0xc2bf9f87215ddb3215914bee887281a64bbb893dd92580186c98fff62842840b::math::mul_div_u256((arg2 as u256), (0xc2bf9f87215ddb3215914bee887281a64bbb893dd92580186c98fff62842840b::math::mul_to_u128(get_sui_amount(&v3), get_token_amount(&v1)) as u256), (0xc2bf9f87215ddb3215914bee887281a64bbb893dd92580186c98fff62842840b::math::mul_to_u128(v2, get_token_amount(&v3)) as u256)) as u64)
        };
        v4 - arg2
    }

    public fun get_sui_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate) : u64 {
        0x3::staking_pool::sui_amount(arg0)
    }

    public fun get_token_amount(arg0: &0x3::staking_pool::PoolTokenExchangeRate) : u64 {
        0x3::staking_pool::pool_token_amount(arg0)
    }

    public fun pool_token_exchange_rate_at_epoch(arg0: &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate>, arg1: u64) : 0x3::staking_pool::PoolTokenExchangeRate {
        *0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

